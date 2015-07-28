From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: populate cache-tree on successful merge
Date: Tue, 28 Jul 2015 12:55:46 -0700
Message-ID: <xmqq6154dpkt.fsf@gitster.dls.corp.google.com>
References: <1438111840-6403-1-git-send-email-dturner@twopensource.com>
	<xmqqa8ugdpu7.fsf@gitster.dls.corp.google.com>
	<1438113266.18134.26.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Brian Degenhardt <bmd@bmdhacks.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 21:55:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKAyf-0001bC-9L
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 21:55:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbbG1Tzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 15:55:49 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33531 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbG1Tzs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 15:55:48 -0400
Received: by pdbnt7 with SMTP id nt7so75745597pdb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 12:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Owo+F8/ZEXtypTn/p4DxGOeAMAaTAfaerr9EH/Xdxi8=;
        b=aUPhKihdAYA/SPrope2/BN6fy2GhMkfyW0jNLypBOXBTeHAWf1G67ZsDiDvZ4ktqfM
         KrkpAkGFEZ6h2GfT896neiGLk+93Ik/gH78dBSpH2YuqqjWwhPm2sPBY9egCL+QIcy5+
         3/wZZ3HHuLBHn2JfFGCgzXNW//qNaQ4TR1/lLrap1F/HKWAQqgGsvov7uqBziZhbmSXF
         sN81YylShQIVc5DqLn0PXbgaqPMGvgy4GAVaFpOG70AxGccGGrLt5Hx+7Af29bxblul9
         TMVleAgm2bCmyp0SZt1gTuFWmAULd60TEh1N2jtCkIPjITdQPDnIeswcfLqhgkFhfNPG
         52Ig==
X-Received: by 10.70.129.102 with SMTP id nv6mr85242476pdb.55.1438113348493;
        Tue, 28 Jul 2015 12:55:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id or7sm31549494pdb.9.2015.07.28.12.55.47
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 12:55:47 -0700 (PDT)
In-Reply-To: <1438113266.18134.26.camel@twopensource.com> (David Turner's
	message of "Tue, 28 Jul 2015 15:54:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274823>

David Turner <dturner@twopensource.com> writes:

> The work done to produce the cache-tree is work that the commit would
> otherwise have to do.  So we're spending extra time in one place to
> eliminate that work in a different place.

Good point.  Thanks.
