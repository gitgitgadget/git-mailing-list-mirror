From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [RFC/PATCH 0/3] JSON/XML output for scripting interface
Date: Sun, 11 Apr 2010 18:45:52 +0100
Message-ID: <d0869259b375a26df46ef92a2b973615@212.159.54.234>
References: <20100411112928.80010.1786.julian@quantumfyre.co.uk> <k2pfabb9a1e1004110848u15859465qf14e3d40eb4ba877@mail.gmail.com> <cb4ed5763e71bd84b4e80109923494ca@212.159.54.234> <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>, Eric Raymond <esr@thyrsus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:46:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11ER-0006T2-Sk
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634Ab0DKRpz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:45:55 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:50872 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab0DKRpy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Apr 2010 13:45:54 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 3E7CF819C6D7;
	Sun, 11 Apr 2010 18:45:47 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 070E420CF4D;
	Sun, 11 Apr 2010 18:45:53 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id G2NHzDYCBJ6h; Sun, 11 Apr 2010 18:45:52 +0100 (BST)
Received: from webmail.quantumfyre.co.uk (reaper.quantumfyre.co.uk [192.168.0.2])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id A55A5554CB;
	Sun, 11 Apr 2010 18:45:52 +0100 (BST)
In-Reply-To: <w2lfabb9a1e1004111034n1aec73f2h3cf5f1d8468b6036@mail.gmail.com>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144665>

On Sun, 11 Apr 2010 19:34:13 +0200, Sverre Rabbelier
<srabbelier@gmail.com>
wrote:
> Heya,
> 
> On Sun, Apr 11, 2010 at 19:30, Julian Phillips
<julian@quantumfyre.co.uk>
> wrote:
>> you'll have to tell me what you think.
> 
> The patch does look fairly simple, but I worry that not all commands
> will be so simple, that is, they might not all have such an easy point
> where you can hook in a different output method? Or am I seeing bears
> where there are none?

I think that there probably are commands where it will be more work to
integrate the output - but I think that is probably more to do with the
structure of the current code than the API of the new.  Does it make a
difference what the API of the new output code is if there isn't currently
a sensible hook-in point?

If code has been written without the expectation that the output format
could be changed then the effort to add a new output format could be
considerably more than for status or ls-tree.  However, with the
frontend/backend design hopefully we only have to endure the effort once to
get multiple output formats.

-- 
Julian
