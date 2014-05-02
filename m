From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: RE: BUG or FEATURE? Use of '/' in branch names
Date: Fri, 02 May 2014 17:10:52 -0500
Message-ID: <536417ecd0104_1c7bdcd2f0b9@nysa.notmuch>
References: <5363D1B4.1000503@lge.com>
 <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "simon.busch@lge.com" <simon.busch@lge.com>
To: Keith Derrick <keith.derrick@lge.com>,
	Keith Derrick <keith.derrick@lge.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 03 00:21:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLpo-0006ST-BF
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:21:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbaEBWVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:21:32 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:63350 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbaEBWVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 18:21:31 -0400
Received: by mail-ob0-f175.google.com with SMTP id wp4so5892575obc.20
        for <git@vger.kernel.org>; Fri, 02 May 2014 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=fJPj0fnvE6kj8a3G/8hJGvQ5bJbZIrlf35GpogoE0ps=;
        b=qxfw6bAeiQ+jIcAomBc0f4pzPnSZTDpgDdWQYkbZ71rdfeILdc6Xgvbb0zHwCRDlKj
         q3mgkR7v+XYNTOrsqj0b/FX8ziDBNBlQfXYgyxQoRmo1A5FVn7Kf6sk3vhPniSXnFKRV
         g5B53N/DP9yegdNuSV74cf097c1Vr5NFUiObH/gOUqFZq3f8yIKKZpVbKO5TP16QDqms
         fMXMtAhYAJqzw4vQz/QC+J4o62J3E1GCasnfVB/3qT7RvD6dk6OJYqluCxhpZp11kOnO
         5YDaUnWjh+Yhc5Diw0cEd9L6LIqiDXadF1d8Px8cuy0rd7aCOmXM+UzXDmvIL8n2PZ35
         ONTA==
X-Received: by 10.60.44.135 with SMTP id e7mr4351832oem.63.1399069291568;
        Fri, 02 May 2014 15:21:31 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id a7sm651256obf.19.2014.05.02.15.21.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 May 2014 15:21:30 -0700 (PDT)
In-Reply-To: <AAC0CF0A2CCEC34CBE983015FD81C4F7392A504B61@AICEXMBXCL02.LGE.NET>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247996>

Keith Derrick wrote:
> I can see the value in grouping branches in a directory tree under
> refs/heads, but wouldn't it make more sense to simply escape the '/'
> in the branch name so that 'hotfix/b1' is stored on disk as
> 'hotfix\/b1'?

This would be nice for remote helpers: Mercurial can have "hotfix" and
"hotifx/b1", so importing such a Mercurial repository creates problems.

-- 
Felipe Contreras
