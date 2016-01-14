From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [issue?]'git branch -D' case sensitive issue
Date: Thu, 14 Jan 2016 12:51:05 +0100
Message-ID: <56978BA9.2010005@web.de>
References: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?6YOt6IW+6aOe?= <tfguo369@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 12:51:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJgQx-0006M8-AB
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 12:51:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324AbcANLvP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2016 06:51:15 -0500
Received: from mout.web.de ([212.227.17.12]:54995 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbcANLvO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 06:51:14 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M3k8j-1a1juL0Chd-00rK57; Thu, 14 Jan 2016 12:51:12
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <CAB4fgE81JHzU=KmN9e=pjsurboipQ3K-pMu-26j+o+FU5G7tQQ@mail.gmail.com>
X-Provags-ID: V03:K0:dOARJfSlVw1LS/jXy+2MNfvXL7df5zBCRjWqeu0VpNLKCKmOojd
 gVGqR9ugun34wEvbIBN5orJlb651VcSbHbLUAAdysn5bWiICzDu5fqLepORptVfMAfYokkX
 1ZmX8ebh2529I+fEmmjqOvno+YRIYgUGKFbMV1We11QX6bVwI7hcV97z64yp+In6ivTuNXU
 czAIhrHUGjhtQUaD3cWzg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ynP2uDIuIvk=:/i9G8UuGvfRmtXQajDJiUa
 imgKQhQvN1bDTRGqdFxgUYLvPSqNax1Y52NIMK+B9N/dNiCNJOofPMABNJSU5p7P2UykRj7ot
 Ifk1uukdPI2bzZaiRbc3zsekVgEM1k1VCdXU9FmZHcMR11jvdUb/4KSDtLjaa8L3nOmusQW9j
 oTpkqDx1dQ+5twixb4vhjZUDX1dB7fRP/qtkarYA0Seyx3yWEO3n8IhRSjlPouSKZqGaUjRyM
 8kVdrlUd43NboPlsFSKo/AAy5a/Mjkqc/yEvLfTvrdyYX+5khtHOkQPLoQV63LrwAwf+vCk84
 bLTg12xEB6EtCWL19zkSQnmJVJm5pWpKTQxM82WS1RW38b0LdyrIesU1X75+73BmAQ3SBToqD
 Jtj2NaegMayU0tzjV9BkU0FyOlEtwNAyNYTPpBNQUv+R40jHCi6p6DfMpUEM977gxBd3vDVBM
 BppzJeHpBhwl2u9HTC5MpxwfgPhtYAgcEHQMEsqJXDofv4OAWGkvYqgQfoy+VADPzSVqxrm6d
 HMIBoq4KNoLcekqY+ag59e34jtorkGeJ5JmSyy7Ra1YnR7e2VHwbw5B6tz89Oz8S1nRke1iL4
 tb28qm3w1hvTJWSio+Weh9Sd7FsiqZp81sbcvC0ZhR7HRuSBrB6d9+G9Lbo4zdF6O2r7WCat4
 ZO+6RCj6eY6aX9YjRo/FOtEQWf98KJlv55AXdfzV8P0KmgVgIdUxh0nDEeBougBhos4kGFCvu
 eGy92YohB3SRhBakM7cxeTTW02XdZOoXz6IrCZtr18eai9IN2/ff+/ApMVaAAEhTiDeCFcr2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284032>

On 01/14/2016 08:52 AM, =E9=83=AD=E8=85=BE=E9=A3=9E wrote:
> Hi All,
> I encountered some issues when using 'git branch -D'.
> It's strange, the command 'git branch -D' is case sensitive.
> Here is the operated log.
>
> =E2=9E=9C  my-emacs-conf git:(NIce) git branch -avv
> * NIce                  fed5d9c Update js2-mode $ js-beautify.
>    master                fed5d9c [origin/master] Update js2-mode $ js=
-beautify.
>    remotes/origin/HEAD   -> origin/master
>    remotes/origin/fake   8ec9cad fake.
>    remotes/origin/mac13  13ae483 mac pro 13's config.
>    remotes/origin/master fed5d9c Update js2-mode $ js-beautify.
> =E2=9E=9C  my-emacs-conf git:(NIce)
> =E2=9E=9C  my-emacs-conf git:(NIce) git branch -D NIce
> error: Cannot delete the branch 'NIce' which you are currently on.
> =E2=9E=9C  my-emacs-conf git:(NIce)
> =E2=9E=9C  my-emacs-conf git:(NIce) git branch -D NICe
> Deleted branch NICe (was fed5d9c).
> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 git branch -avv
>    master                fed5d9c [origin/master] Update js2-mode $ js=
-beautify.
>    remotes/origin/HEAD   -> origin/master
>    remotes/origin/fake   8ec9cad fake.
>    remotes/origin/mac13  13ae483 mac pro 13's config.
>    remotes/origin/master fed5d9c Update js2-mode $ js-beautify.
>
> Hope someone can give me a hint.
>
> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 git --version
> git version 2.6.3
> =E2=9E=9C  my-emacs-conf git:(NIce) =E2=9C=97 sw_vers -productVersion
> 10.11 OSX
>
> BRs,
> terry3
> --
If you can give us a hint, under which OS you are working ?

I assume that you are on Windows or Mac OS ?
In this case the file system is part of the problem,
which treats NIce and NICe the same.
