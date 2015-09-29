From: Christophe COEVOET <stof@notk.org>
Subject: Re: Gitk cannot start in the latest version when using --all
Date: Tue, 29 Sep 2015 15:51:46 +0200
Message-ID: <560A9772.80503@notk.org>
References: <560A94E7.9090506@notk.org>
 <20150929164951.cd5dea4ab0e866e4a0b74d6f@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <kostix+git@007spb.ru>
X-From: git-owner@vger.kernel.org Tue Sep 29 15:52:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZgvK8-00020s-CY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Sep 2015 15:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbbI2Nvz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Sep 2015 09:51:55 -0400
Received: from nautica.notk.org ([91.121.71.147]:41017 "EHLO nautica.notk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965415AbbI2Nvt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2015 09:51:49 -0400
Received: from [192.168.1.4] (jav75-3-78-192-133-84.fbxo.proxad.net [78.192.133.84])
	by nautica.notk.org (Postfix) with ESMTPSA id 8E040C009;
	Tue, 29 Sep 2015 15:51:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <20150929164951.cd5dea4ab0e866e4a0b74d6f@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278822>

Le 29/09/2015 15:49, Konstantin Khomoutov a =C3=A9crit :
> On Tue, 29 Sep 2015 15:40:55 +0200
> Christophe COEVOET <stof@notk.org> wrote:
>
>> I'm installing git and gitk from the Ubuntu PPA maintained by the Gi=
t
>> team. I received the Git 2.6 update today.
>> Since this update, I'm unable to launch gitk with --all. I'm
>> receiving the following error message:
>>
>> Error in startup script: bad menu entry index "=C3=89diter la vue...=
"
>>       while executing
>> ".bar.view entryconf [mca "Edit view..."] -state normal"
>>       invoked from within
>> "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd n=
e
>> {}} {
>>       # create a view for the files/dirs specified on the command li=
ne
>>       se..."
>>       (file "/usr/bin/gitk" line 12442)
>>
>> Launching gitk without the --all option works fine.
>> Launching gitk with the --branches option or the --tags option is
>> also broken
> Does it start if you run it via
>
> $ LANG=3DC gitk --all
>
> or
>
> $ LANG=3Den_US.UTF-8 gitk --all
>
> ?
Yeah, both of these commands are working fine.

--=20
Christophe | Stof
