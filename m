From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: Bug report: Unhandled Exception
Date: Fri, 19 Jun 2015 16:19:42 +0200
Organization: gmx
Message-ID: <35ee961018eec1fc84f4c3db16c5a9bb@www.dscho.org>
References: <DM2PR06MB4936C92C10128BD37E4ABC1D1BC0@DM2PR06MB493.namprd06.prod.outlook.com>,<d13c20eaeeed4fefe6a7911bc08ea59f@www.dscho.org>
 <DM2PR06MB4931E4534120B4A65580CA7D1A40@DM2PR06MB493.namprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gary England <GEngland@myvrx.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 16:20:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5x97-0006wk-NV
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 16:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbbFSOTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 10:19:49 -0400
Received: from mout.gmx.net ([212.227.17.21]:49864 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbbFSOTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 10:19:48 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MXZNq-1ZaFYX1BcU-00WZn4; Fri, 19 Jun 2015 16:19:43
 +0200
In-Reply-To: <DM2PR06MB4931E4534120B4A65580CA7D1A40@DM2PR06MB493.namprd06.prod.outlook.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:I+CT88THxvc8AB/SYn3+aGvpPnPJrOUyFHWYPZD37ilZSbcZnTo
 Ui6swMNRDGpIro+Mul2FSuGkfdOa/hzz828qVHt+MT8uU8w5+oslToh25hk/MbZKm519lYi
 1eMuMd+MUMscwhMDNy8aQCkDFB6koBAoYaIF/jGg0nSBC51UHDNZiWF+dZVFjP7mMD+OkP7
 xf4aQyzNp6roRY/ChZ63g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2ExRJj260YY=:fsB3Auv6F3B4N19DSmMx5H
 r/o6PT/pKi5SiJZSfmNNC5pWhz/TuFiU24+0uZ/dnPFeoG2CXOMN6byjnlJNuDmFew5AtHoEn
 u6YNeR4BhaWqaFKRlFZgPAZyx79xEul1ov/9k2g7FPE+nM+WR2YdWjEfW5wYbbXVg31YRkpMU
 UK8evO2bCitvooSzk5lWmX5W78ihxulXdCCbf7duOd9G21gDYMs8kBwWC/X7u8F6eGnvLYCV5
 DVaoqGeCsE4eLczaRIG95gwMcqCASOsS6esilb9z/XX1I8h6rbiZQab9ryZLuNJKBvg+e0smj
 ArPbMMDHMOCfBGa/oaRS8C70RkYANcnh9xkdRZtvcU3rBIT2HigpEXrxtVkULHr08niWOBH2s
 R0V4HrfXDQ2HbVLDPaajT6V04p6ACBNeVM3YuhLNQW3Bn8BfHdy7yZ6bIeEYcUeoXhZ44bMzj
 xospRJI9RP17zwGFEMlfitWCuaVbYzjKFonI7eQNP39DtM/AJBY+4XxiDEL4dMyeks4udGsya
 RvmUgJVr8ZOYyRFa21TdHk69i3STGo47B6bStwDPLBpZXDasqKveCeol2oqkpu22qIOGBaxqt
 79Ff/dY/HR4yvptCd1viIbGXuq++DpF2P6zm8ejswK51pgeu9nEc66WD2UZ92LJBrmTZmAmJl
 5rM88FxKQ5gtLLs15clGtOdtEK7BajYTUkyOGerb0EQLWkiKPzsRTCWWzdKkF55ceuvU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272158>

Hi Gary,

On 2015-06-19 16:09, Gary England wrote:

> Will do. It's unlikely that I'll be able to reproduce the error. But,
> in the event that it happens again, I'll let you know.

For the record, the problem usually lies with a certain implementation detail on 32-bit only (if you know the `rebase.exe` tool -- confusingly completely unrelated to `git rebase`! -- you will know the root cause). That's why it is typically a sporadic problem only.

Ciao,
Johannes
