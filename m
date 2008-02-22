From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git.el: Add a git-grep command
Date: Fri, 22 Feb 2008 11:21:34 +0100
Message-ID: <200802221121.35706.jnareb@gmail.com>
References: <87odaa4tcl.fsf@lysator.liu.se> <m3myptcqji.fsf@localhost.localdomain> <87tzk19wn5.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Alexandre Julliard <julliard@winehq.org>
To: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri Feb 22 11:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSV2q-0003Oc-K3
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 11:22:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755046AbYBVKVp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2008 05:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753600AbYBVKVp
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 05:21:45 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:21109 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbYBVKVn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 05:21:43 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1244602ugc.16
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 02:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=Mhx/q594fg/jiHwrLGzX/woAQW4S8Zk/qLg5J6lKHW4=;
        b=VVoW8C2UUeI78u454jTfXuLgIU4ToidK8k3bqVSxrR/r6ghcaxTNGLejTz3/uePR3957u0dDJ1cEFV6YVGDF6bnz8nNL9EW1xF8S42CHeVe4iQVNKAR+JUIWAZamU7t9TnSFY0YTKUktqgSVk0OlOs7zr0y8FH1BRbkRjaDHcUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C5Bd5GiGbQM36L45Ifwkt7hwD+VR5qTlXo01cvqkbcqTvy023UpEn8+vpSKjM/Vl++P358l++4Jus/kxXq9Zp7nXWdfyku9bEBGzKvi7cHR1IZYI0n+ZLNPIaTJ3WQy8sAa7dSZ4bUu5WsCPStljH7KiEK7pfM/badDLf3lOIHA=
Received: by 10.66.255.7 with SMTP id c7mr2154640ugi.43.1203675700583;
        Fri, 22 Feb 2008 02:21:40 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.207.245])
        by mx.google.com with ESMTPS id l20sm352161uga.62.2008.02.22.02.21.38
        (version=SSLv3 cipher=OTHER);
        Fri, 22 Feb 2008 02:21:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <87tzk19wn5.fsf@lysator.liu.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74712>

On Fri, 22 Feb 2008, David K=C3=A5gedal wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> David K=C3=A5gedal <davidk@lysator.liu.se> writes:
>>
>>> This works for me, but before including it someone else should try
>>> it. It might only work in Emacs 22, for instance.
>>
>> emacs -batch -f batch-byte-compile git.el
>> [...]
>> While compiling toplevel forms in file git/contrib/emacs/git.el:
>>   !! File error (("Cannot open load file" "grep"))
>> Done
>> make: *** [git.elc] Error 1
>>
>> 1078:[emacs@git/contrib/emacs]# emacs --version
>> GNU Emacs 21.4.1
>=20
> As I suspected. The problem is that the grep commands were rewritten
> for Emacs 22, and lots of it can be reused. So to write a similar
> command for Emacs 21 probably requires a bit more work. And since I
> use Emacs 22 I'm not sure I will feel motivated enough...

Could you make it at least conditional on the Emacs version used,
or even better depending on the fact if "grep" 'library' is available?

I'd like to be able to use git.el with my Emacs, even without some
functionality. TIA.
--=20
Jakub Narebski
Poland
