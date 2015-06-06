From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/11] create ref-filter from for-each-ref
Date: Sat, 06 Jun 2015 19:13:32 +0530
Message-ID: <5572F904.1080608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 15:43:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1ENy-0008MM-UN
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 15:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711AbbFFNnj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jun 2015 09:43:39 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32958 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378AbbFFNnh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jun 2015 09:43:37 -0400
Received: by pablj1 with SMTP id lj1so11573850pab.0
        for <git@vger.kernel.org>; Sat, 06 Jun 2015 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        bh=9Dn1NudL9F2/vwabvlHM8VtMs8wEbkUavPChGVWbfQM=;
        b=RZugsZyo4m2URwWmuWCjMf5zZneYhNZ2+6qkCXgnwvtayDtPsNrcHBhTHMIZw7hosM
         fg6ZoPWDW5sM0hQGSPpz8eYnTjpD+TrWXS2W0IboKmkbVI0c8n+fZgndP87yDY7coYIY
         m4VBbRACPzy5oxUk2dQecwpMokyKkO7SGt2y5X4Q9yVnWcRdwGbDSpJdJwLqZZM6gUSe
         aicPz2EqVD84L176fJZ2z5F+CFfCUhdzYbE1JynPT55+oCYt1cQrWil7s6PlbMi+awL6
         Bz852uw6vSnqgLSilZCYlbdPyMHCOBDc9aZAEDKtXiQJOJu443QZPG+HChY8PvMkg4mm
         Hg9A==
X-Received: by 10.68.178.229 with SMTP id db5mr14406664pbc.17.1433598217215;
        Sat, 06 Jun 2015 06:43:37 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id f1sm9721217pds.62.2015.06.06.06.43.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Jun 2015 06:43:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270922>

Version four of this patch can be found here :
http://www.mail-archive.com/git@vger.kernel.org/msg70280.html

v5 : http://www.mail-archive.com/git@vger.kernel.org/msg70888.html

Changes in v5:
*    Rename functions to better suit the code.
*    implement filter_refs()
*    use FLEX_ARRAY for refname
*    other small changes

Changes in v6:
*	based on latest master branch (github.com/git/git)
*	rename variables named sort to sorting.
-- 
Regards,
Karthik
