From: =?UTF-8?Q?Stefan_Fr=c3=bchwirth?= <stefan.fruehwirth@uni-graz.at>
Subject: Re: malloc memory corruption on merge-tree with leading newline
Date: Mon, 15 Feb 2016 22:54:56 +0100
Message-ID: <56C24930.1010606@uni-graz.at>
References: <56C2459B.5060805@uni-graz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:55:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVR6k-00037V-RY
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbcBOVy7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2016 16:54:59 -0500
Received: from EX07HTCA01.UNI-GRAZ.AT ([143.50.13.79]:33775 "EHLO
	ex07htca01.uni-graz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608AbcBOVy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:54:58 -0500
Received: from EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) by
 ex07htca01.pers.ad.uni-graz.at (2002:8f32:d4f::8f32:d4f) with Microsoft SMTP
 Server (TLS) id 8.3.406.0; Mon, 15 Feb 2016 22:54:56 +0100
Received: from [143.50.232.174] (143.50.232.174) by
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf) with Microsoft SMTP
 Server (TLS) id 15.0.1076.9; Mon, 15 Feb 2016 22:54:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <56C2459B.5060805@uni-graz.at>
X-ClientProxiedBy: EX13MS04.pers.ad.uni-graz.at (2002:8f32:dc2::8f32:dc2) To
 EX13MS01.pers.ad.uni-graz.at (2002:8f32:dbf::8f32:dbf)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286266>

Addendum: Problem occurs with version 2.7.1 as well as version 1.9.1.

On 15/02/16 22:39, Stefan Fr=C3=BChwirth wrote:

> in one specific circumstance, git-merge-tree exits with a segfault
> caused by "*** Error in `git': malloc(): memory corruption (fast)":

Stefan
