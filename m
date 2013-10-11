From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Fri, 11 Oct 2013 18:54:13 -0500
Message-ID: <52588fa5c7d1c_5dc4c2be74274fa@nysa.mail>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
 <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
 <522E3C6A.3070409@bbn.com>
 <CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
 <523B51A1.7030409@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 02:01:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUme0-0000YF-Ms
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 02:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754204Ab3JLABL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Oct 2013 20:01:11 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:60687 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab3JLABH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Oct 2013 20:01:07 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so3013232oah.29
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 17:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=WtepYnmaegrG7rEsycePP3XpvoPqOrjAxeegmQ89xCw=;
        b=Ynw/TE2gPCRMD3ldQK8g3BfhjugzJj9M/japyE+gbMA/3aRSVJwrnad2GzpWNeeBKD
         j1C89aGvOJcNsrb9vj7u4wkj3vcsdfQfSJR0ZavLGJv6/e5EcUjQ+027WuaaAXxinbf3
         j1+r6N3D8N4FaGdOlSBy2HBO5W6giKKzRFqmQLgLvRzJKavRatkmrv2JtB/5dJzf0qQ5
         sk5xCji1mRJUIWDrWhesUvOwrtDiECkpwwiLIOyX8mlDAnpYev7rLVBSRyGr+7cjMGdy
         tEuuFOjJroALGq2ksR4df7RBVfKvqEmP+fZfXgghw4Xgg7gllLAII5XCcgrVS6rjENMQ
         k18Q==
X-Received: by 10.182.44.167 with SMTP id f7mr16415939obm.3.1381536066804;
        Fri, 11 Oct 2013 17:01:06 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm99063288oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Oct 2013 17:01:05 -0700 (PDT)
In-Reply-To: <523B51A1.7030409@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235928>

Richard Hansen wrote:
> On 2013-09-09 18:49, Felipe Contreras wrote:
> > On Mon, Sep 9, 2013 at 4:23 PM, Richard Hansen <rhansen@bbn.com> wrote:
> >> On 2013-09-08 21:23, Felipe Contreras wrote:
> >>> The old configurations still work, but get deprecated.
> >>
> >> Should some tests for the deprecated configs be added?  We wouldn't want
> >> to accidentally break those.
> > 
> > Probably, but Junio is not picking this patch anyway.
> 
> It sounds to me like he would with some mods:
> http://thread.gmane.org/gmane.comp.version-control.git/233554/focus=234488

The modifications are already in this series.

-- 
Felipe Contreras
