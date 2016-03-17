From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Thu, 17 Mar 2016 06:35:44 +0100
Message-ID: <56EA4230.7010501@web.de>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net> <56D333F1.9050905@web.de>
 <20160315015954.GB25295@dcvr.yhbt.net> <56E79C54.8000606@web.de>
 <20160315070930.GA24036@dcvr.yhbt.net> <56E999C3.4040802@f2.dion.ne.jp>
 <56EA3DBD.2070105@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 06:36:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agQbK-0004kP-U6
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 06:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753256AbcCQFf6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Mar 2016 01:35:58 -0400
Received: from mout.web.de ([212.227.15.3]:55921 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195AbcCQFf4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 01:35:56 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0MaJc8-1aMZMg3eqe-00JtfI; Thu, 17 Mar 2016 06:35:46
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <56EA3DBD.2070105@web.de>
X-Provags-ID: V03:K0:TcfuHhiOg0QCDBvLk2QnGu8lVWSsaEjjeqBYJMLJrc/KF4DTB48
 LA4/1UAYmHXvuk0IA24YZXPc/0RI/3Z34qzyfNf8FVyZaHcLQa49dj5Q6DEdqPcOJVSqX5V
 0Y+Bn13GsaGAVsvDVWDInvYtUFntUNknp/63ZJKOxPDxbQXGggFA/IPji4prYM/sxta5aht
 DsNhGQCgwmxpNITxc514g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0zR++fqvDTM=:Gviis9pKpDCeppL0cmtP9m
 GNxBO/MJfwTPYzEoZmn6Ao/GgeHMFxEyv5zc/fuxmICS9d4SBu+7cEDH5zub3rx9BdpbuQPEK
 c7P8IBpdvRigJUUjQvrk9AQWv6tDDEgGYnDQ8wwoiOKC8LO4YQnzpJBA/IwXtjZEwei60uhJU
 Oo7Ihg2IgIR+cQnYcGq1yYQhJeXNROaRntk/0VQWJau5ShkjLN92/70vgs8FVdJo6YP6anqRH
 /z3QnxFpcHwh21np3FYzw61/tnbivCv/eiAirkqniMrkETvU8gDuvbysh/8U51nwXuI5CKp6f
 2ljIb/31eIkCgmm83JrPe8j4QMrpho/saJADInQwqkePj78DD1CDkHk8TidhA2Y3YU2DI7Z0V
 WbcHUNCgw2MWybaFS1AZfVVCVd8pDkWNPjTHgf+1dChi9gN44hHUfXzkcF91ByL3Ic5MjIyUC
 Xpa2WUt6ZZ1xJXediBR6ZvXyIMbJloWUH6l0wvcNbRFM+Z13A98mv1BJKLzJh8ZYWgJGzf0Yc
 tnDR/A7N5BQYmQ27T2X4kLnciR3L1GfocSnvBisQGG+iJqsBCm44DbX5FVP9Lbi8/KAkqGutj
 IpTa2hIsrBP6uXrQLAtpcdURKMFqg8lLv5dI/VUMiWCFYG1UkCxmiAc5NRJjYuOJUuGvcQGgH
 DjoER7sa84SDVfRl/GtGWvDrYCUSPYMfseFuFdl4OWW355H2qtq3enrQ5BBXe573qjw5l0EBv
 3MWcZ0bNEQsiLIOpj7BoOyUlPFrbp22OuI7H2L+SNT3a+Jzi+vvvNGoee15eWJyQSpxBF7e+ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289075>

On 2016-03-17 06.16, Torsten B=C3=B6gershausen wrote:

Oh Boy,
typo in the last patch and t9115#11,12 where skipped on Mac & Linux :-(

The "case" should look like this:

> +	"$neq")
> +		true ;;
> +	*)
> +		false ;;
> +	esac

And the pathch is here:
<https://github.com/tboegi/git/commit/866dfc192a0d4428aebfc7242f5134899=
b6dafd4>

Kazutoshi, could you re-test on your environment ?
