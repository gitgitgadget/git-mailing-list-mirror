From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update extra!] git-remote-svn: Week 13
Date: Sat, 31 Jul 2010 00:31:27 +0530
Message-ID: <20100730190124.GA2995@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 30 21:03:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeurX-0004wg-OD
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 21:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760371Ab0G3TDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 15:03:11 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63833 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760392Ab0G3TDH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 15:03:07 -0400
Received: by pxi14 with SMTP id 14so658945pxi.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=BAviygljVrmUxZF2Dk/AIA8YjHvuVDpdvxj8alCE/vU=;
        b=n2xCcy1k8NzAiJHSzET/enbOAkb/dmfOCRh4DkuDgLGwV4oQG5gwPA/PSXBo8GRaEi
         n48wEp6IU+cxgjzXLHanMDjqrdLIdfhAnPDiHJantFdzhR8utn5L0ZKqyiFwiB1uWAyn
         NGTT94aFlQB+/TucISFiE9F9HQgwjGmfeCn9g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=TUCx5T/4zp86rMk3F7uh7M1+6f3cR9CRNoCoqs6WkFODtbDXyN45c4bO79BM1DDczg
         OKQ88/HI2YMzTLI9Y+eU/efT5TKUmshbvPjaqYTf6M8Ae+Gs6pinrWIoTCzZY8u7mE6f
         bgKCoHnHVX51+XLbymbCK+6ENKf28gsYg508c=
Received: by 10.142.177.4 with SMTP id z4mr2138380wfe.280.1280516586653;
        Fri, 30 Jul 2010 12:03:06 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id x18sm2909243wfd.20.2010.07.30.12.03.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jul 2010 12:03:05 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152261>

Hi,

I just got a proof-of-concept loader for Subversion working. It just
about works for a very small reduced case. I'll still have to hammer
it into shape for to handle various cases [1]. In the meantime, we
also have to start working on doing the inverse of what
svn-dump-fast-export does: convert a Git fast-export stream to a
Subversion dumpfile.

David: Can you estimate how challenging the task is going to be?

[1]: I'm working on it directly in trunk. You can find the latest code
in subversion/svnrdump in the Subversion trunk.

-- Ram
