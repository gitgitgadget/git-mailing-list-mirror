From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: How to move users from SEU (AS400) to Git?
Date: Wed, 2 Dec 2015 13:22:19 -0500
Message-ID: <00fe01d12d2e$61875660$24960320$@com>
References: <1CA7E776-B216-4AA5-BFE0-63C0B066980D@npcinternational.com> <efe2b6d70905121431p79c05addh1cd5759221ae911c@mail.gmail.com> <1449079797917-7643587.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'dleong'" <dleong@celsinc.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:22:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4C2w-0002ns-96
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 19:22:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731AbbLBSW0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2015 13:22:26 -0500
Received: from elephants.elehost.com ([216.66.27.132]:12895 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756220AbbLBSWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2015 13:22:25 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gojira (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id tB2IMMkx061007
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 2 Dec 2015 13:22:22 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <1449079797917-7643587.post@n2.nabble.com>
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdEtLLBLrpUlvDeYTsuF80vl6OSFiQAAIIDA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281899>

On December-02-15 1:10 PM dleong wrote:
>I stumbled on this topic while doing a research on how to move RPG source
>control to adopt using Git. I wonder if the original question was answered.
>My company would love to have a more central system to maintain both RPG
codes >and javascript codes. We use Rational Developer exclusively (no more
>SEU) for our developers and we do not have budget to use Team Concert from
IBM. >So Git seems like a good solution.

I don't see any reason why Git would not be happy with RPG, whether
structured or not, providing you have a reasonably Posix-like file system.
The Rational Suite includes ClearCase, which can also be converted to Git
(BTDT), although it is a bit intricate to convert and the complexity depends
entirely on what part of history you want to preserve.

Cheers,
Randall
--
NonStop and Unix geek since before the CSNet mass migration.
