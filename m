From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Unable to clone a repo over an IPv6 link local address: port
 got trimmed to 4 chars
Date: Tue, 24 Jun 2014 15:15:52 +0200
Message-ID: <53A97A08.2020304@web.de>
References: <53A9735E.8080604@luminar.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Vincent B." <vb@luminar.eu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 15:16:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzQaH-0007zU-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 15:16:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752484AbaFXNQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 09:16:21 -0400
Received: from mout.web.de ([212.227.15.14]:61123 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaFXNQV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 09:16:21 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MDxKd-1Wu97d33cN-00HKwO; Tue, 24 Jun 2014 15:16:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.5.0
In-Reply-To: <53A9735E.8080604@luminar.eu.org>
X-Provags-ID: V03:K0:mDEuNnIUM1jTc5DG9SrGBHBB86n5Udr96HKXrTJX3MWFHLRNW8P
 JKTvNpjAleJyMr/AS121n8iMHYN/IUIvnBRG0zVtiAFu1bgm2LElzjkL6lECE92motbPDsi
 Qnk72l9lfF4ZoXDOpTFCbYzodI56pdyUiMnpD8+OPHdiXwIKdUoyg7ByZ6OAneE0ALSTQ3S
 F9cZYVwfqietTETjgD/2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252407>

On 06/24/2014 02:47 PM, Vincent B. wrote:
> I discovered an issue while trying to clone a git repo over an IPv6 link-local address:
>
> [vb@nerenyi ~/code/ocaml-llnet]% LANG=C git clone "http://[fe80::226:c6ff:fe50:efa0%wlan0]:33075/repo"
>
> Cloning into 'repo'...
> fatal: unable to access 'http://[fe80::226:c6ff:fe50:efa0%wlan0]:33075/repo/': Failed to connect to fe80::226:c6ff
> :fe50:efa0 port 3307: Connection refused
>
> It tries to connect to port 3307, and not 33075, strangely.
>
> Cheers,
>
> Vincent Bernardoff
Which OS are you using ?

what does
git --version
give?

And what does this do ?

GIT_CURL_VERBOSE=1 LANG=C git clone "http://[fe80::226:c6ff:fe50:efa0%wlan0]:33075/repo"
