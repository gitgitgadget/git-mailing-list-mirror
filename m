From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git history and file moves
Date: Fri, 24 Oct 2008 15:13:02 -0700 (PDT)
Message-ID: <m3vdvhhc5s.fsf@localhost.localdomain>
References: <1224640967.14280.0.camel@minggr.sh.intel.com>
	<81b0412b0810220419q43f6985fs1c608e3d3cbcf8f3@mail.gmail.com>
	<48FF1EDB.8010503@drmicha.warpmail.net>
	<4911F71203A09E4D9981D27F9D8308580AA7FFFB@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	"Lin, Ming M" <ming.m.lin@intel.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Moore, Robert" <robert.moore@intel.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:14:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtUvK-0001hr-PA
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:14:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbYJXWNN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756549AbYJXWNM
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:13:12 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:19925 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756079AbYJXWNK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 18:13:10 -0400
Received: by ey-out-2122.google.com with SMTP id 6so382049eyi.37
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 15:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=zWrWkaN5e/qPZ/HiDSCxQGmoq/s8bWGFenvwkEYbf/A=;
        b=ou53jIMbgiDYwvB2ywuq6StSVC365PR/uHiEuC0JaIB3lyVhmOdRsUUkHD3m6bjSB1
         +XSUOjoe9LQnzxlcB9OSNhDC7Hgll/XZOPUziDrhQK8TIHaWrgmKOeCZrmhzK3aVEzfv
         SVmTSpOyxzEnh5CtFWSuZtjlY5AuaLLvp3+nA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=fzd5Rh7nFHv7N/fb9xUU1PfGW3E7Cb6gAlT10NR+xJgznbQMm3TwFMivqs9uXWLQxt
         0FW9N6TX5MZuSiP6Vg0lwa1ytb5Rc33UaAOqMbWLWb3UK6CyspRz3ZLArBiStNShz9/q
         FudKm7UID2/uUWOotF/QpjWQrhX+AmNGm11z0=
Received: by 10.210.142.6 with SMTP id p6mr2979951ebd.100.1224886388791;
        Fri, 24 Oct 2008 15:13:08 -0700 (PDT)
Received: from localhost.localdomain (abwm208.neoplus.adsl.tpnet.pl [83.8.236.208])
        by mx.google.com with ESMTPS id 3sm1019031eyj.3.2008.10.24.15.13.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Oct 2008 15:13:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m9OMGIwZ024470;
	Sat, 25 Oct 2008 00:16:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m9OMGGS3024467;
	Sat, 25 Oct 2008 00:16:16 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4911F71203A09E4D9981D27F9D8308580AA7FFFB@orsmsx503.amr.corp.intel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99072>

"Moore, Robert" <robert.moore@intel.com> writes:

> 
> Thanks,
> Bob
> 
> >-----Original Message-----
>Michael J Gruber wrote:
>>Alex Riesen venit, vidit, dixit 10/22/08 13:19:
>>> 2008/10/22 Lin Ming <ming.m.lin@intel.com>:

>>>> I'm looking for a way to move files to a new directory and have the
>>>> full history follow the file automatically. Is this possible?
>>>>
>>>> I know about --follow, but I want the history to just follow the file
>>>> transparently. ...
>>>
>>> Of all Git tools, what does not do this "transparently" or "automatically"?
[...]

>>>> Also, we have a git web interface and we want the full
>>>> history for the moved files to be available.
>>>
>>> It is available. Whether it is shown is another question. git-web can
>>> be improved (or just configured?)
>>
>> By default, gitweb uses "-M" for diff. You can specify all options (-C,
>> -CC, -B) using  "@diff_opts" in the config file for gitweb.cgi - if that
>> is what you are using. Is it?
>>
>> Anyways, using default configs for git log and gitweb.cgi both of them
>> show the full history (renames, history before and after) for me here,
>> using current git (1.6.0.3.514.g2f91b). What is your setup?
>
> Here's what we have:
> 
> /var/www/cgi-bin/gitweb.acpica/gitweb.conf
> 
> Containts this : GITWEB_CSS = "/icons/gitweb.css";

This fragment has nothing to do with rename (file movement) detection.

> 
> What should we add to automatically get all file history?

While the 'commitdiff' view would, in default gitweb configuration,
contain information about file renames, currently 'history' view does
not support '--follow' option to git-log.  It wouldn't be too hard to
add it, but it just wasn't done (well, add to this the fact that
--follow works only for simple cases).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
