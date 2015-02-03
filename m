From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2 1/4] apply: reject input that touches outside $cwd
Date: Tue, 03 Feb 2015 06:56:19 +0100
Message-ID: <54D06303.7050100@web.de>
References: <1422919650-13346-1-git-send-email-gitster@pobox.com> <1422919650-13346-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 03 06:57:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YIWTs-00032o-CP
	for gcvg-git-2@plane.gmane.org; Tue, 03 Feb 2015 06:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966003AbbBCF4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2015 00:56:55 -0500
Received: from mout.web.de ([212.227.15.3]:61895 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965172AbbBCF4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2015 00:56:54 -0500
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0M8iK4-1YUbIp2152-00CCvW; Tue, 03 Feb 2015 06:56:47
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <1422919650-13346-2-git-send-email-gitster@pobox.com>
X-Provags-ID: V03:K0:Ehc7ery5QIWVL51LarJqpUzJi3cJJpQeEHcnNRqRZln2xrbJeFN
 eCkEZqj4cyNhWR0qTpG/vkbopAhG43EJ4z9/d0iJ2VKBKYt07/75yRCLnE1YPkTGOmJUBbz
 PPwYXKYQKaWzzEKA51Kg8DFxro6tXdBFo782PE7d0Or0yisXrbuvTMTrl4Olbax8z2B+5aE
 q4dBiEtfXeKNqK690FRXg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263308>

If I am allowed to to some load thinking:

The commit msh header says:
  reject input that touches outside $cwd

The commit message says:
   By default, a patch that affects outside the working area

And the new command line option is this:
   --unsafe-paths
(Which may be a good choice to pretend people from using it without
   having read the documentaion)

(And isn't working area the same as "work space" ?)

I have the slight feeling that there may be more unsafe-path situations coming
up in the future..

Will
--allow-outside-ws
or
--patch-outside-ws
be better ?
