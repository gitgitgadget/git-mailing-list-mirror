From: "Feanil Patel" <feanil@gmail.com>
Subject: How Blobs Work ( Blobs Vs. Deltas)
Date: Tue, 30 Sep 2008 10:14:06 -0500
Message-ID: <16946e800809300814v134a42dft37becdbd8aa7669a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 30 17:15:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kkgwa-0003K6-Ma
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 17:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbYI3POJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 11:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYI3POI
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 11:14:08 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:24879 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbYI3POH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 11:14:07 -0400
Received: by wf-out-1314.google.com with SMTP id 27so75195wfd.4
        for <git@vger.kernel.org>; Tue, 30 Sep 2008 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=lmK3vvpvf4V9/uQ5jMhBOBS2ZD/5hslTDPEEn+1diJw=;
        b=oVlJFe6MIGBVdyOM1o49zNMQI0DSL3g4mnpNPYzmXLcFNNay+Gr9MJP6cpdgAvx6R2
         KmaMEASW8mrU9jbbT+FEwrDQWupAsCQ7ShcwOVcDPuxqgRv1zJJZJ6fzlORizKSwomWU
         gytmnBAzGUZG4+xdnkjhGCq837sozAJpnhv1M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=gaYehmVM2tpB25LzH3GE0D+VHRfls90BtDA4CKjoKD28tpqetABbwSpOx0SiNoFLpT
         qQfhPcGI+WphgcM1p1kqHAfnuX0qGuOWNYASU/kRv+cbBs+UlM6CxlHojlx2hnjvea/E
         2cO2H2xIYBPq37fsJk3riXzADkTyilJS4o+Cg=
Received: by 10.115.14.1 with SMTP id r1mr7656274wai.206.1222787646488;
        Tue, 30 Sep 2008 08:14:06 -0700 (PDT)
Received: by 10.65.137.10 with HTTP; Tue, 30 Sep 2008 08:14:06 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97125>

Hello,

I was reading about git objects on The Git
Book(http://book.git-scm.com/1_the_git_object_model.html) which was
posted on the mailing list a while back and I was wondering something
about blobs and how files are stored in any particular version.  If
file A is changed from version one to version two there are two
different blobs that exist for the two versions of the file, is that
correct?  The Book was saying Git does not use delta storage so does
this mean that there are two almost identical copies of the file with
the difference being the change that was put in from version one to
version two?

-Feanil
