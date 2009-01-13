From: "Emily Ren" <lingyan.ren@gmail.com>
Subject: How to pull remote branch with specified commit id?
Date: Tue, 13 Jan 2009 17:08:34 +0800
Message-ID: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailinglist" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 10:10:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMfHb-0002fM-39
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 10:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbZAMJIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 04:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755083AbZAMJIi
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 04:08:38 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:50525 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751471AbZAMJIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 04:08:36 -0500
Received: by gxk6 with SMTP id 6so126787gxk.13
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 01:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qyulQtlk5Vp77XdHU8VliWF5H9P2YzP333AaKy3G1Bc=;
        b=IqnEqHmRNh8q6NJVBz4OHm9YjHT1mjhSBYY27/hXsu3uLm2yopPRIe6Nn0tB9Bqg/d
         f3uITO/l7T6bzFMFDXKXp0l9AWf389xu00tb/Ogllw6X0zwHH19Fe1WNA4xCI1ZaPkUv
         TCnOJ/eNtPu19DHqK2uGjXrVRqO2WWDgRnUZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=u07c5elpVfatq1FkpaHrXYxrPQls+bvDgfXAP9BnYTTjRVHZ1bLlUjp++b8mHW+EvN
         GFCA34mEIywQUh27WVKwGiDxAdER+z1yp7sJ9is2O1vSwPfg7BsEkpyOxUwdSOmplfls
         nf3RYfkzsZfwmPlWLGZhiNrrXSRN1W/Fyagfk=
Received: by 10.151.6.2 with SMTP id j2mr12129003ybi.50.1231837714696;
        Tue, 13 Jan 2009 01:08:34 -0800 (PST)
Received: by 10.151.107.12 with HTTP; Tue, 13 Jan 2009 01:08:34 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105475>

Git experts,

I want to pull remote branch with specified commit id, how to do it?

Below command can get remote branch
$git pull remote refs/heads/$branch_name

Below command doesn't work
$git pull remote objects/$commit_id

Thanks,
Emily
