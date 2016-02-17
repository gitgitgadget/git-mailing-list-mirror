From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 2/3] config: add 'type' to config_source struct that
 identifies config type
Date: Wed, 17 Feb 2016 14:12:44 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602171412080.6516@virtualbox>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com> <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, peff@peff.net, sschuberth@gmail.com,
	ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
	hvoigt@hvoigt.net, sbeller@google.com, gitster@pobox.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 14:13:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW1um-00020Y-CT
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 14:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161429AbcBQNND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 08:13:03 -0500
Received: from mout.gmx.net ([212.227.15.19]:59776 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964898AbcBQNNB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 08:13:01 -0500
Received: from virtualbox ([37.24.143.97]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MTSKd-1aMrE02CDX-00SR0F; Wed, 17 Feb 2016 14:12:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1455531466-16617-3-git-send-email-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:XDL+/FcBNy20sx4Mud+0d6vt9q/P16fr91AA0miBrupGhQHNo3y
 gyZwOk5Vs+guiuOFERpQoE8VkHe3SAIWFRdSn/1PAlfsAjlGNtbjZYWgAXo99J5hayT9i1j
 O0eEzwBEsB6XGWEP0eoYK7/4ncrEzbupnNMIoWQ03/2o9IcjFhCDcl9IZUT43BskRhbR3LC
 TX1YDAEqAERdNTPkJlbSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TMneAQNGEdk=:0bkoLclaw/EBROgYAwXmWP
 YncpVNJQTsrdaxTtK4gXqFYfWk51kJd8nx5A+RyI8zRCaA1kD53uIKMZucGgnOCHfLGCiwxlP
 Vv/8m1d2f8/EZgsFunRqVB42PaDXEwELk6dnPU4GtL7Ib4t7AnVVre1rI1g9iatFzcNxAudsP
 OFWO1SCVjuFnkR2A7Ml/VgJBezW755cgutbT0e/RSr2WJx4qfdCnhbpzuvjgPAOhT+wNyyViQ
 s7864FiZ1R0wmw2tTgUJhE1+SfwxKxj6Ak6MGy9Aiy7geGiKZYFWty2mHz8TjAtR3JJ17KGjt
 4JCzG+8NvO4VKjXNwP5QvrJhydgpuPaTb8A6QnyeICdd3FeIvMzBAA9sfyqDH1X/okrPkciOB
 n+rnJtG59Yo+l65rUmLLw0XAAOSFtefn2r9DyPYcf8IrHWN0oSCQiCUXDDCKFrX8/NXcJPYTC
 mSWLWFY91GN2RX0rhDDT2bvtdo6OaDqmxCIHW0fkviZwQk2OEk66RlwZ/nXCrwQowWfElnTaU
 dv3cTaoK6kptKFSvHi4SfIRKIC7Th5yO+hS5MZEBx3eDAe3MxbIGr576d5r2407A+0r5Tt3Ar
 KcYKdhGmXTrw329YMrxnF18hjX8344Da/AyojlOPaAF/yUoHXK9ti9fhzVfqM3WAe+/CM1YdW
 8dz8FObU+Dzmf8nDaeLh44KQwj8D6Kf/HRlbixcaqp0p1QEVZhG19tUCDg+GFRHy/CF4meAUw
 vl0/BhkRdFOpxYtYpGwSZKEneFlU4kVK8re0QCEapNDLnDB4DJjpswDpeoLsLNMSAppQt8aR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286497>

Hi Lars,

On Mon, 15 Feb 2016, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Use the config type to print more detailed error messages that inform
> the user about the origin of a config error (file, stdin, blob).

Given that you settled on `--show-origin` as the command-line option, I
would have expected s/type/origin/g, too...

Ciao,
Dscho
