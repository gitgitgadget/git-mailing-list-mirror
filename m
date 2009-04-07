From: David Aguilar <davvid@gmail.com>
Subject: Updates to the latest {diff,merge}tool series
Date: Tue,  7 Apr 2009 01:21:18 -0700
Message-ID: <1239092483-14973-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 07 10:23:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr6aW-0005e5-OI
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 10:23:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754764AbZDGIVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 04:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754680AbZDGIVp
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 04:21:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.233]:3518 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175AbZDGIVn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 04:21:43 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2620149rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 01:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=nGmG2axytOqiHh5L4HnZKcfhiBRmfFNRv8uWKAv0c+s=;
        b=dgNzv9zXlQtcy/t4tfFgKbwllbs5OJbIrJeeUJtE7NHT9+BHOcLmbHjjjnRS52eWzd
         TzXCUbiSZWZJvB7qJyrsuhpCRHDoYQMjwrVGN1qp/XEUtIDWRRxQiqAakElLCyZZEGC7
         jFY1t6bRugEvc5P7wbCEQWUutjCaw4ArOuvZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ULGj6Q4NSlpLrsAR11A5iSNZe1eVi8zLsViRNy7aOH5QqDyS/IxwdHeC+o5q5v+Wi7
         6EdoM2sAur/6AgoZ6gesOPkuHYrSCjXi4GUf/q7TlinJ7QUQiPSNmQD1oO1HSHlyEFro
         Th2InZjwL3/yo+OPBlj+5QnEzTXNYJaJNy8g8=
Received: by 10.114.26.18 with SMTP id 18mr2786396waz.159.1239092501349;
        Tue, 07 Apr 2009 01:21:41 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m31sm6591570wag.64.2009.04.07.01.21.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Apr 2009 01:21:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115931>

Here they are.

07/14: Updated usage synopsis
09/14: Updated diff.tool config.txt documentation
10/14: The original broke the test suite on Mac OS...
       Testing {diff,merge}tool.<tool>.path is tricky.
11/14: This depends on 07/14, so the rebase requires a resend
14/14: Reworked logic as discussed.
