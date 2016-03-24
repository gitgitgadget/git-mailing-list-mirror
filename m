From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH v9 3/3] commit: add a commit.verbose config variable
Date: Thu, 24 Mar 2016 11:04:36 +0100
Message-ID: <1458813876-10591-1-git-send-email-szeder@ira.uka.de>
References: <01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 11:05:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj28m-00030q-Re
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 11:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756951AbcCXKFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 06:05:11 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:52567 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755182AbcCXKFK (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Mar 2016 06:05:10 -0400
Received: from x4db26f6f.dyn.telefonica.de ([77.178.111.111] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1aj28W-0005ot-E7; Thu, 24 Mar 2016 11:05:06 +0100
X-Mailer: git-send-email 2.8.0.rc3.58.gc805582
In-Reply-To: <01020153a7ba4ec2-1fb668c3-9dc6-4137-8d92-c6a5825a156c-000000@eu-west-1.amazonses.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1458813907.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289730>

> Add commit.verbose configuration variable as a convenience for those
> who always prefer --verbose.
> 
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> 
> ---
> The previous version of the patch are:
>  - [v8] $gmane/288820
>  - [v7] $gmane/288820
>  - [v6] $gmane/288728
>  - [v5] $gmane/288728
>  - [v4] $gmane/288652
>  - [v3] $gmane/288634
>  - [v2] $gmane/288569
>  - [v1] $gmane/287540
> 
> Changes with respect to the previous patch:
>  - Compare with -1 as only -1 value is used for unspecified behavior.
>  - Write clean tests
> ---
>  Documentation/config.txt     |  4 ++++
>  Documentation/git-commit.txt |  3 ++-
>  builtin/commit.c             | 13 ++++++++++-
>  t/t7507-commit-verbose.sh    | 51 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 69 insertions(+), 2 deletions(-)

Please always run the full test suite before submitting patches to
make sure that your changes do not inadvertently break something.
This patch breaks several tests in t7512-status-help.sh,
t7508-status.sh and t7060-wtstatus.sh.
