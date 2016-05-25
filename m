From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [BUG] can not escape sharps in git config file
Date: Wed, 25 May 2016 07:11:58 +0200
Message-ID: <5745341E.4080305@web.de>
References: <57442992.6030306@gmail.com> <574439B3.9090308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Jean-No=c3=abl_Avila?= <avila.jn@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 07:12:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5R73-0003xG-I5
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 07:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbcEYFMF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 01:12:05 -0400
Received: from mout.web.de ([212.227.15.3]:50935 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750733AbcEYFME (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 01:12:04 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0LbIiI-1bqIWT3j4M-00kw56; Wed, 25 May 2016 07:11:59
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <574439B3.9090308@gmail.com>
X-Provags-ID: V03:K0:DooOk1ceFroqDIzr8ivaaawFKebHTzYpIQmsDcbC+qr18jWbSzn
 rqGRY4KA43a9+PoWsBad8m6vY7c5F22ukuxujdwXbGmkY7fjN0floqNgK9lzivyVXeUN57y
 JcT0q6+eADFEU14tzE//mVQwOG+2ZyoHA7dQzP/HDSNvP5krVfgYy+E7lawFjnUgaTnhB9g
 oeXii9zFh1kAPlpnWCezw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2SEQQD+kswY=:9AtorQmn39OESim1Qi3cQn
 QhTm+rnr1go7518m9bUJvsQ6GaiQERsuQxdrdU+c0oHn8xWn29Xt6Xhi8VV6ywz52L7yH9ZZS
 aTbJtivrpqU6l6UyD1iGM/skGx2x5cRZfFmS3RCbOfYp6QbPWE3u0JDUBLVeaSaf4wKqNLaBP
 mc1KuqFwosciNDmKN+qc+2t8KgMeYy3qSCHBR317BoJGCaxXkP/40mQ9sqSNy315uQcEXnOuC
 lOwSAeQzxKGb81GsTcKUd4nsH9AsjtDSmj+teyKS4VL9KD9JcXkoIRiwy/TlkYXqlnCpveKuX
 Pf0X53LRAO5dlMQ9hWhqnwIhbTyk1mgtvvQjd8J2W6JgURIg2tjo2+vMY+HHeEX43A7xebue4
 D/sDV9Ef9wKBk8nOQirx/e4ahoRi5YjLxRgt56Xs9l0SPQxd6bFahqve9mmor/F8Q3/pk+1qa
 SPZPPlhPadW5DOBbXtSyWLreEEBxJu8pHE5Uk7PvOvrvc32je3IUIhVY6gV00bcOpak1/Sj1j
 BU+J/SoQ1fa9Hl+CUDpmHPNn7jRauMqA4d0BEgBM2YfA57BUkfFQ3MfM89K7MhzgQF/3Km7dd
 9NkvPEeGadbA6L5QBZbnEz7jm7aueNp3WoVEwa4Aooczp7P6n3VjasB/ZKtFZOqVN7OO1RN5t
 ctOIdhXo9lY1N3c6wJPo7rl5LpkSo8boNOFl/0KtqzOZhRNNzyNYamiSBJLSgOt5jKPfDkL2H
 fYQR6oCjvWq/L8uzvqxRkcyTEgTCges46q6E27/UrqcZaqrVZYvWESkFzC/YgfbvAN2UYGYU 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295558>

On 05/24/2016 01:23 PM, Jean-No=C3=ABl Avila wrote:
> My mistake, sorry for the noise,
>
> JFTR:
>
>   * only double quotes can fully escape a string (it is safer to encl=
ose
> the whole value in double quotes)
>   * backslashes have to be doubled because they are interpreted by gi=
t
>
> So
>
> [filter "kicad_sch"]
>      clean =3D "sed -E 's/#(PWR|FLG)[0-9]+/#\\1?/'"
>      smudge =3D cat
>
(I'm not a filter expert)
What happens if you put the sed expression into a shell script, and
configure the filter to call the script instead ?
