From: "Aneesh Kumar" <aneesh.kumar@gmail.com>
Subject: Finding changes in one branch not in two other branch
Date: Tue, 15 Apr 2008 16:51:59 +0530
Message-ID: <cc723f590804150421j689ef4b1o57b97c937e23db99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:22:58 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JljFR-00012B-Dc
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757935AbYDOLWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757916AbYDOLWD
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:22:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:58334 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757903AbYDOLWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:22:01 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3084931waf.23
        for <git@vger.kernel.org>; Tue, 15 Apr 2008 04:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=MqL11RllBn5NqK0riV26BJ7fpmDiK/8ITbYTqN8ScSk=;
        b=CQNBjGtZE/JWPcTib4NcrDnvdHF+f5fV7GraHjzqEdXW/t5ZGGIjzkkNr4Y4U9ZJOyOWio1oIHBjC8NGrZn0MFuUwYov16XRB/YRb00agrLdBrl9KfjylsDBGJAGIWjDzTenMHgA2k8Bp/NTfnlfkLhDVKC62pgSzBcEwsjzmoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=skFGppRpkwh43F5p3x1F5Rs/XqiPO9qoTexbv9CgVyN4HmDLBfpxhSnguRAuMg97N87nc6/6/Vod0cYdUsFIzXppWg0WteWxYoPckF2eLvCKCaX2INuX9GPDuJwfg1v7j4/NZvzGPyG6uyAYpFR5EAWx7AmdF8GJGauRVDTUdK0=
Received: by 10.115.79.8 with SMTP id g8mr4803750wal.215.1208258519478;
        Tue, 15 Apr 2008 04:21:59 -0700 (PDT)
Received: by 10.114.150.8 with HTTP; Tue, 15 Apr 2008 04:21:59 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79586>

Hi,

I am not sure whether it is available. What i am looking for is

git diff <commit1> <commit2> <commit3>

And it should show changes only in in tree represented by <commit1> but not
in both <commit2> and <commit3>

To show a workflow:

kernel releases 2.6.20 and the project release patchset on top of 2.6.20
kernel release 2.6.21 and project release patchset on top of 2.6.21

The second release involve some bug fixes for the project.

The intention is to find out  what changed in project with the release
of 2.6.21 patchset
. The easiest is look at diff of diff. But if git can do it for me why not ??

-aneesh
