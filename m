From: Jay Soffian <jaysoffian@gmail.com>
Subject: allowing aliases to override builtins to support default options
Date: Fri, 6 Mar 2009 17:30:43 -0500
Message-ID: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 23:32:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfiap-0003VY-H7
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 23:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033AbZCFWaq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 17:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbZCFWaq
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 17:30:46 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:35895 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbZCFWap (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 17:30:45 -0500
Received: by rv-out-0506.google.com with SMTP id g37so700827rvb.1
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 14:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=L9dWhja+6dwFMouxiapCHLKyIcdhD/Qy3Kf/kMopHXk=;
        b=pWNeyCc4gIVWGJE7hBF5WfH5G8RXa7oknxSUc48yho09b0z75ckc9M45Bdd+RTqmyd
         yzBuBNATYH2uKFJFFcuKyPP31i82L+nx0OHRZPpcjXSnf64YYm54p77NByOunyOD0jhu
         MKIFvcapZ3J9Y2C7Cf51J+t4DWDFphI40hR1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=hvvN1u2sA+lA26NTwg3FB0ziW6H8aSspOPU0NVLT0t4mqWnQdiWp77oCgMuUHcyhU7
         wVuSNdpySchwmDKAq4CU+gGsX6kHfkmVugdV5VP+5SzjR0DVwZfI99bD1ATyXSpP0RmX
         8OYfgJ8nahJpIYehrKTmdWi85kp5TLxgViuRs=
Received: by 10.141.29.8 with SMTP id g8mr1497585rvj.283.1236378643322; Fri, 
	06 Mar 2009 14:30:43 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112487>

Currently git does not allow aliases to override builtins. I
understand the reasoning behind this, but I wonder if it's overly
conservative.

Most shells support overriding commands with aliases, and I'm not sure
why git needs to be more conservative than the shell. (Although, I
will say, I hate when vendors alias rm to "rm -i", etc...)

It seems like this would be an elegant way to support default options.
Were it to be supported, it should probably have an escape hatch, such
as git --no-alias COMMAND, and it should probably only apply to
porcelains.

Thoughts?

j.
