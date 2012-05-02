From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 2/2] cmd_fetch_pack(): fix constness problem and memory
 leak
Date: Wed, 02 May 2012 15:35:49 +0200
Message-ID: <4FA13835.7080204@alum.mit.edu>
References: <1335955259-15309-1-git-send-email-mhagger@alum.mit.edu> <1335955259-15309-3-git-send-email-mhagger@alum.mit.edu> <CACsJy8AE7Y1Y5Drda39OfSKwTQN7oSSrb2Ai+jq_hi8XC4dtsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:35:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZin-0004pI-Is
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809Ab2EBNfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 09:35:53 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40616 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab2EBNfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:35:52 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q42DZnMs003844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 May 2012 15:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <CACsJy8AE7Y1Y5Drda39OfSKwTQN7oSSrb2Ai+jq_hi8XC4dtsw@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196814>

On 05/02/2012 01:14 PM, Nguyen Thai Ngoc Duy wrote:
> On Wed, May 2, 2012 at 5:40 PM,<mhagger@alum.mit.edu>  wrote:
>>                 const char *arg = argv[i];
>>
>> -               if (*arg == '-') {
>> -                       if (!prefixcmp(arg, "--upload-pack=")) {
>> -                               args.uploadpack = arg + 14;
>> -                               continue;
>> -                       }
>> [...]
> Ugh, perhaps you can convert the above to parse_options() too while
> you're making changes in this part? You can say no, I'll do it (my
> itch anyway).

Sorry, I have too many balls in the air already.  But feel free to veto 
my patch if my changes make it harder to switch to parse_options().

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
