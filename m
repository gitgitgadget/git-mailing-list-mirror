From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Apr 2016, #06; Thu, 21)
Date: Fri, 22 Apr 2016 07:01:41 +0200
Message-ID: <5719B035.6070103@web.de>
References: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 07:02:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atTEM-0003T6-7Z
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 07:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbcDVFCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 01:02:07 -0400
Received: from mout.web.de ([212.227.15.3]:50343 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbcDVFCH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 01:02:07 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LqGCu-1bO79N2sW8-00dje8; Fri, 22 Apr 2016 07:01:53
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <xmqqy486r4co.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:BuAovTWxkj8txNYcH5KSGOCj4KTlOmDJ+N2aa0IvJnkJwlU2V8Y
 4UKugLc5NxHipKoC375pVj8zq7PnfUrvOVLCbG0tVZNc6+1yVLmPq+Lne8ibNETjiMk+wA6
 NwSTepJrZM9QXaVexQrGn+QwhOwubGYSGkRGwit5MptxqQ9uupt3i3SGFTfTEI4HXT2qE5+
 YXXBOEH8cXj3/vb8v9izQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:plrCDEz+pPM=:q1h7w/wstox1Iw8wFbXyzZ
 zgEWCCC71L+AmVV/Ook7wZ1hmFBOz5ccNbN979vvfBdQGiDQ30/cQNhKGNWapoOXtvpQWlqLO
 nzsxSpb95TyBRSe350aqmdG7S8/smRl8ZoPFfg5roglcF5zj7EkYphj6MN+Arh2VPD53JTQac
 uYoVn4mXUsWrUGMKTT+4nEJndxWXGglVYG/kQWj9GijIxPZJHanQJNyJyxZOE9GTlFoKfjMwR
 1vntINwmK6QMiJYD8dm8fxuXYiTzcsVUrFUPy0DVECmBus8wKeErYytv/RRz8EqqhLsssTQW6
 26DF2m3yeONenWaUc5wZPYad/sSKnXl7/pDDeekMn/rgo0boGPQ+wh39vF/HcO8dHkKklnYM1
 vGO0+Ga1rEojSr6w+N2E6Cyq97DPtM59Y68+aev8Cwu6T7l2tuUteYUt3LhJPr3VTMmZowp7c
 Vna64CcGdJjhSAbrPac4iPFXZbxV0UtGT2e9gYR7rBZCAIybitwgQMgN8bWHJKth3NcpcmNsG
 /6XoDCDCs1mRtx8wvBWVaipZFIR0rUdjHWXn7A3ScDTerJvVWY0yiwlzVRPDfKHrknXE1gdvi
 5sMGXd/C/7fws9ccPQRhUaoF7chTiMQ9JJ0MpCF3/ZF2TRSnr1z9F2i+USliSVWdXjGvEaVwh
 kU+3CxF/P77zSBsk3pdfWN3ojt4w0rU+eHPZ+zoLKjPW2wvSStRqpUcrazM2tfisRmbUvEQVg
 ogNBFdIlts+Z9UvA4FmsS5Yj6ku9lY4vTkC1suQ4DjjefVALvd1iMFsxYiLWFdPkU15Ql4Xy 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292166>


* tb/convert-eol-autocrlf (2016-04-19) 4 commits
  - convert.c: ident + core.autocrlf didn't work
  - t0027: test cases for combined attributes
  - convert: allow core.autocrlf=input and core.eol=crlf
  - t0027: avoid false "unchanged" due to lstat() matching after a change

  Setting core.autocrlf to 'input' and core.eol to 'crlf' used to be
  rejected, but because the code gives precedence to core.autcrlf,
  there is no need to, hence we no longer reject the combination.

  Will merge to 'next'.
I know that I asked for an early merge of 4/4, but there is a new version
with a fix for the leaking filter coming out this evening, european time.
Please hold it.
