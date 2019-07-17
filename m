Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF0C1F4B6
	for <e@80x24.org>; Wed, 17 Jul 2019 10:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfGQK7t (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jul 2019 06:59:49 -0400
Received: from mout.gmx.net ([212.227.17.22]:46747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfGQK7t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jul 2019 06:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563361187;
        bh=6k4k+JHOgj06VyjZTdCYX2GM7Y+8RE1L8PqMRJOqZAU=;
        h=X-UI-Sender-Class:Subject:From:To:In-Reply-To:References:Date;
        b=G6Y+LmykvAWeRaGXLUgyYZHGofet5cHXwPd0EMX6R95skvbw6eDYq59Gebia87jW5
         zPiVs9zWJ+xcaj4rDBJwfJnEKlcDvLtUy2ic4R2/S35NsvXfOwIGhubdTAAXPAHNki
         ay+IqczvPoOg1LH7nnT24nNDnTWNdKfEPGhr5guE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost ([94.79.149.170]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LrNoG-1iS99z263g-0139LN; Wed, 17
 Jul 2019 12:59:47 +0200
Message-ID: <61d7947142367c3abf6d6f0af60181a0677ce954.camel@gmx.net>
Subject: Re: git p4 sync: "str expected, not %s"
From:   "Massimo B." <massimo.b@gmx.net>
To:     Andrey <ahippo@yandex.ru>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <23610851562985541@iva7-634c9cb1f49d.qloud-c.yandex.net>
References: <34d6121da46f35e4b81d38169b1b86ca123cef37.camel@gmx.net>
         <17077551562900174@sas1-9134aa144859.qloud-c.yandex.net>
         <edb1cc8f69e59015033604530513ff58f0bf8256.camel@gmx.net>
         <23610851562985541@iva7-634c9cb1f49d.qloud-c.yandex.net>
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAAA3NCSVQICAjb4U/gAAAABlBMVEX///8AAABVwtN+AAAACXBIWXMAAA7EAAAOxAGVKw4bAAABGUlEQVQYlUWQsUoDQRCGv71LjB7KSSBwwZCTgFhY2EYIHmJnZRMLo5AXUMRCBMHcE6iPoGBlINpoZXGVeQTFKqSxMgYtTBFcZw7EKfZn2Z2Z7//hr2ysZ+5tqFLmWKVaKKs0vWd9TJx2AibmoQcupj6CCZirqTgzA5hmsdtQWe5/xAREX7uJ3MLP9x4lyieNO5mcOxyM8HH79y/4Cdn9R3JDsts/uGO82yOMJf/ah1Y8tfQEIQt7Z7rCawtNiUpHFgYUdgTxgI1NAW6SvxoqWabbw0Bd5jpQibTNBC1F4nIMk2TWhTqIs+fSVpzfCsVR9eaiJf5W6mtWXK7O+vKR4nWkSYSuFbP4No3Ht6dpSN9pSMYmaXI1/usXT0FM3SoTKAAAAAAASUVORK5CYII=
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 17 Jul 2019 12:54:46 +0200
MIME-Version: 1.0
User-Agent: Evolution 3.30.5 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3D8g9r4D7EQinF2nEU7RObS+1WKnLZJugJVM+5o2bg/HBv3//eX
 287QorOVyxik5jwzs01FdE4yAXa3+/KBWur0e0lGnGr7/7GMIDuoyv7HIVLDBfKMEcrP9RQ
 2mZ8bpmAM8vIZFPD+2u39QsMUMfmRZ8kOqDlKkzNqOahwIkXpfqpvV0TVlOJvRfEDjwtyVS
 tTyVGVtcy/9TTPPjGUfsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1SakzwKrOC0=:k+PnMzokSbZDD/+b32/ssS
 N0XVdEWDOPOj3SpkNBmKlYYFIB8nr10hobpJhpOXArUaGzAHieiPrs0tIU79do3J+ozTS1UiB
 y4S4ztVglWz08leTcBfkGdsmy1UD08wOppdURr4OqJQMxzaYqpG8OI10NyqvtDEjthjyamv/H
 Bg3h39zL4J2gOtFLYmy60ZX+NPifBR0i+oba4/+UAyZXsrkgGzybwy7pUohJA6jbBPjW37UHU
 cifG0hr/W9JVWlQykSISQPV0Njt/Jycitzzcx2Ltz8DwlgaAyNItDsBko7+/s6KlaycVej2w6
 6aZJdRAyGQkYy0Q6DhUQBkzEiqt7MKN+vlKgHlNEx5XUef1rqT6slNbukDhur7CjOM4JI2Uez
 SMpzCEUSov5MgdRhiArn2e4yWeYNVfagQ2NrboSbl0lV7ooBp3xEATaVvAJ08UPSzhJDPzOMP
 oSwHoQdjQbi5fUabBcMI+zt88bJHn6j9zhJBdEwx76Z3dRdsFd9L77ejw5W58NDfyqDbymdiI
 L2GCqVPCRH0fmwBJ2EWCMBPUbvg0PHywZI3XGjGYsSg6r8225TjvXXD/APnZ1PcwPHvkqxgUV
 k7SbyPRERjiESO+80+20+oSS2t/zsb3MhSrkYUC4tNJS3I0JfAQx7mH3VCLOad9990gKzkQu3
 lCVtrsP3hulWNV86tmt2wAEZ5SgVeDqsbk2ZJ1LLqLE7z//5QvO53xkdI2eoPI39uey2BuW+D
 SWNkTrewDCvC9hjTMJK1mMVJ8h0vTIgauLqYIIm41fqdQQXwtDMyRH5WS/JcTGmAjc6nU0aDL
 6DX2cVfiiv8fni3X1JYz596SnRTyRUkVZ5Bpf2PSVLjl3M8pGRinaWweCPkZ78S0phNAhXBjD
 L0CbV/JZDEG9vqyzaQeNvL4WdaXitMirlOY00fZeE77xOdcTG5BG81BfGCiO3vRGOf81uAPRC
 2LIpIoozlKeD7cajpc6Ogig0qF2o3tNEhMvf58RT0FNcKGAkhmekIiTexzCin+fa9v0I4uiIf
 5NVaDDEIWPKtac8TY1uSX5QgXtP4HUfg5epy8yLr6vjJ2B5in6hcwsbyHzZrolwhgxIotYYgx
 svY6STeaaGDnwFo3zvFsyY5sjHFRJJ0R3m+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Still failing:

On Fri, 2019-07-12 at 22:39 -0400, Andrey wrote:

> Could you, please, try the patch below?
>
> diff --git a/git-p4.py b/git-p4.py
> index 5b79920f46..f5be048348 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -4137,13 +4137,13 @@ def main():
>      if cmd.needsGit:
>          if cmd.gitdir =3D=3D None:
>              cmd.gitdir =3D os.path.abspath(".git")
>              if not isValidGitDir(cmd.gitdir):
>                  # "rev-parse --git-dir" without arguments will try $PWD=
/.git
> -                cmd.gitdir =3D read_pipe("git rev-parse --git-dir").str=
ip()
> +                cmd.gitdir =3D read_pipe("git rev-parse --git-
> dir").strip().decode()
>                  if os.path.exists(cmd.gitdir):
> -                    cdup =3D read_pipe("git rev-parse --show-cdup").str=
ip()
> +                    cdup =3D read_pipe("git rev-parse --show-
> cdup").strip().decode()
>                      if len(cdup) > 0:
>                          chdir(cdup);
>
>          if not isValidGitDir(cmd.gitdir):
>              if isValidGitDir(cmd.gitdir + "/.git"):

# git p4 sync
Traceback (most recent call last):
  File "/usr/libexec/git-core/git-p4", line 4163, in <module>
    main()
  File "/usr/libexec/git-core/git-p4", line 4157, in main
    if not cmd.run(args):
  File "/usr/libexec/git-core/git-p4", line 3569, in run
    branches =3D p4BranchesInGit(self.importIntoRemotes)
  File "/usr/libexec/git-core/git-p4", line 844, in p4BranchesInGit
    if not line.startswith('p4/'):
TypeError: startswith first arg must be bytes or a tuple of bytes, not str


> Or, even this one:
>
> diff --git a/git-p4.py b/git-p4.py
> index 5b79920f46..2bf6720911 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -196,6 +196,10 @@ def read_pipe_full(c):
>      expand =3D isinstance(c,basestring)
>      p =3D subprocess.Popen(c, stdout=3Dsubprocess.PIPE, stderr=3Dsubpro=
cess.PIPE,
> shell=3Dexpand)
>      (out, err) =3D p.communicate()
> +    if out is not None:
> +        out =3D out.decode()
> +    if err is not None:
> +        err =3D err.decode()
>      return (p.returncode, out, err)
>
>  def read_pipe(c, ignore_error=3DFalse):

# git p4 sync
Traceback (most recent call last):
  File "/usr/libexec/git-core/git-p4", line 4167, in <module>
    main()
  File "/usr/libexec/git-core/git-p4", line 4146, in main
    cmd.gitdir =3D read_pipe("git rev-parse --git-dir").strip().decode()
AttributeError: 'str' object has no attribute 'decode'

Best regards,
Massimo

