From: Jay Soffian <jaysoffian@gmail.com>
Subject: Not possible to see combined diff before committing a merge?
Date: Thu, 18 Mar 2010 02:21:40 -0400
Message-ID: <76718491003172321j2a184643o47ec3a712a3b0c12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 18 07:24:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns99i-0003Fg-Pf
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 07:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701Ab0CRGVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 02:21:44 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:41030 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471Ab0CRGVn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 02:21:43 -0400
Received: by gxk9 with SMTP id 9so1042066gxk.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 23:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=pOX7Jr3185Qg5y3RjktKOoGPbhI9kXG0Uf3qRgUAlzg=;
        b=m25RYarGopJeXmYrrAnZAm/b/9kimr4Hnzj3HBmjbHgyh8m1ArefiOBgoyLSKpLhkf
         I6MBOVTjDmD3DQ9YVBXWI53yNfYVuczIotoMY2DcvcoPPommjRtZjRzRFTpPDNBpH7RG
         sQOb+/QtMJFmBpR4SPPFN2SArFQ4wP6R4pCN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=DORuud0hG2peHsbk1wsAauuIhx11quMLJhe0l1mx0zTiDk8KY/+OVETj5VWZ8jcJwb
         +UPiibGD64dS3a/OVQiaQC3eb7H1MK8w6/oB54PrCCqALtIh5AuPuz2RnXoTzjG/mF3W
         Uuh1a8hMFAqGQRQidSCrKkM3NEHftkmSAZKBQ=
Received: by 10.150.167.1 with SMTP id p1mr1463796ybe.25.1268893301133; Wed, 
	17 Mar 2010 23:21:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142450>

Am I missing something, or is there no way to see combined diff output
after completing merge resolution on a conflicted merge but before
committing the merge?

$ git diff --cc [-- path]

works fine _until_ you've added the file to the index, at which point
you're hosed.

I think I want the combined diff between:

- What's in the index
- The first parent (ORIG_HEAD)
- The second parent (MERGE_HEAD)

And I don't think that's possible, sadly.

j.
