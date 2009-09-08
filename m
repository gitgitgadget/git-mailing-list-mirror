From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Gitweb linking to bug-tracking system
Date: Tue, 8 Sep 2009 11:22:23 +0200
Message-ID: <81b0412b0909080222u58c7e0bey81a5b127b04d6031@mail.gmail.com>
References: <85ab15n8of.fsf@oqube.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Arnaud Bailly <abailly@oqube.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 11:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkwuF-0003ZX-UT
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 11:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZIHJWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 05:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753976AbZIHJWW
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 05:22:22 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:49069 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832AbZIHJWV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 05:22:21 -0400
Received: by fxm17 with SMTP id 17so2464773fxm.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 02:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+gxloZ+mkPBJpUWfZE8WxwX5Ry42DwfPh38/yG0j6sw=;
        b=L3fannPlqV9yVU+gy7LJzhLkftibncqEULEHmIaw1UMvD6vMC0GgktkGO+HBnkv0Q1
         jIEunHzuJYQ4pJCyNAR3fBb+VzG8TPqqhP869UMzh8hlL4TgjKqtBGcEdsAt3t/EB9Wh
         kEMbSkgK2oGIT0Qfd8Flj9eTvtk6bArCIUG+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=A1xxe2MR84BYw9M/AolXPsR02uqjfjafQjh4MKk0zolYjWXn45Md2ngpaWBRPJ+T7j
         WMiI7stCTAI1//ajKlZ8NuMUaVM1idLuvwxNRRjNf6AtPTZC7pFPpv/uQkGsoJsEL0i3
         3OWJ8n70DScCY4uhyWBj0AHFBS8KtPAmhxr1U=
Received: by 10.204.153.27 with SMTP id i27mr3137484bkw.155.1252401743462; 
	Tue, 08 Sep 2009 02:22:23 -0700 (PDT)
In-Reply-To: <85ab15n8of.fsf@oqube.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127995>

On Tue, Sep 8, 2009 at 10:26, Arnaud Bailly<abailly@oqube.com> wrote:
> HEllo,
> I have installed gitweb using git version 1.6.3.3 on ubuntu, and
> everything is working perfectly.
> However, when a commit have a comment containing a string matching
> "DEF[0-9]+", an hyperlink is generated on the web interface which makes
> me think it is possible to link to some DTS. Yet I cannot find how to
> configure this ?
>
> Am I missing something ? Is this totally unrelated to DTS ?

It just looks like an SHA1 and is converted to a link to simplify
jumping around revisions.
