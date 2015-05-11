From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: bundler service
Date: Mon, 11 May 2015 14:37:16 +0200
Message-ID: <CAPabhsJX_vC4SASW4F0uZ9urCLHNP0bS_j5ZcA6xafA8K8YY=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 14:37:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yrmxa-0003wr-7s
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 14:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbbEKMhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 08:37:20 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34229 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbbEKMhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 08:37:18 -0400
Received: by wicmc15 with SMTP id mc15so27113287wic.1
        for <git@vger.kernel.org>; Mon, 11 May 2015 05:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=dDuxYRJ95prHM/i4MTDomriBeNvzcQkxprrvu7mHwfg=;
        b=D/UMntbIJFo1quwE8vtanOvIit/YG8dK1T7KxaXL4usyyAyyWIKoKoxCrvU8GZzdGM
         /v6m/2kV0FRs7u0YvnfenkAoKuuFPy7Fj+RqsdcWQUtxMp/rbrVusCiwsoCZDoVv1DNX
         LzZzeHf3U96YS61+I5bdS/WKUgqOHqthqMj/bqkdSJ3d7SQ4wHgzNVYFTFLouP8drk5g
         C0rQRMfiFYGU1pKxb6Gw86T9lxAYaH/5eO+UUSt1FtNA/EeTiBLKcmEp6gMuVR8vzsbS
         DJ6Z3viaoqmUWFp1K6j4eVTuzOUOXqwQ0BCiZFyGFB3aKup+p9VIIods/bzNNyGxp4P2
         HKSQ==
X-Received: by 10.194.89.130 with SMTP id bo2mr19573076wjb.17.1431347836905;
 Mon, 11 May 2015 05:37:16 -0700 (PDT)
Received: by 10.28.128.136 with HTTP; Mon, 11 May 2015 05:37:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268775>

I used to run a service which packed git repositories into bundles so
people with unreliable connections could download the bundle over
(resumable) http. This helped then to do the initial clone. This
service is not running anymore. Is there any interest to resurrect it?
Or did git solve the problem of resumable clones in the meantime? I do
occasionally get emails asking why it is down. But I don't follow the
community (mailing list, IRC) anymore so I don't know how often that
problem comes up.

The services used to be hosted on bundler.caurea.org.
