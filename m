From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Mon, 12 Apr 2010 00:30:33 +0100
Message-ID: <61c2a556d3b557df82cc5da764b5d0f2@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com> <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234> <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com> <d0869259b375a26df46ef92a2b973615@212.159.54.234> <p2ofabb9a1e1004111050x660c37fdke4d5316baaa0cfbe@mail.gmail.com> <q2i2cfc40321004111522kd177fb89k6b9265c641d7deec@mail.gmail.com> <776480BE-3652-489A-96C9-9312321E49C0@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>,
	Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 12 01:30:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O16bx-0001br-8A
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 01:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab0DKXag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 19:30:36 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:40887 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753092Ab0DKXaf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 19:30:35 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 7EF30819C6C6;
	Mon, 12 Apr 2010 00:30:28 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 31BB120CF50;
	Mon, 12 Apr 2010 00:30:34 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pUzSAzTxjl+I; Mon, 12 Apr 2010 00:30:33 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8DCF7554CB;
	Mon, 12 Apr 2010 00:30:33 +0100 (BST)
In-Reply-To: <776480BE-3652-489A-96C9-9312321E49C0@gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144698>

On Mon, 12 Apr 2010 09:25:04 +1000, Jon Seymour <jon.seymour@gmail.com>
wrote:
> On 12/04/2010, at 8:22, Jon Seymour <jon.seymour@gmail.com> wrote:
>>
>> So, would it be worth providing a hint as to record type in the
>> output_start_object call so that if it was later desired to subsume
>> line-oriented formats under the same framework, there is enough
>> information available to the backend to do that?
> 
> Of course, one way to do this would be to use a more descriptive  
> record name than "entry". This would make the record itself (as  
> opposed to just it's fields) self-describing.
> 
> The point is, you would want to start using descriptive record names  
> now so that you don't end up locked into a partially context sensitive  
> base of consumers who are expecting their JSON records to be called  
> "entry" and using context hints to infer the actual record type.

I have to admit that most of the names were just "first idea out of the
hat" - not really something I was paying too much attention to.  It's
fairly easy to tweak them later, provided it's done before they get
published.

Having said that, I've just mailed out v2 patches, which already include
line-based output (using a different approach). ;)

More descriptive names are probably something that should be done anyway
though.

-- 
Julian
