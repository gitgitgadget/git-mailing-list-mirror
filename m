From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 1/2] rev-parse: add --prefix option
Date: Fri, 19 Apr 2013 16:59:46 +0530
Message-ID: <CALkWK0=nw7fR2EB6YT=Cx4mUxmBjJCAzAszmey0K+QD55NqwyQ@mail.gmail.com>
References: <82316c445320b3cec3a35cbc87ad94a04ed26d1e.1366314439.git.john@keeping.me.uk>
 <1366365217-17674-1-git-send-email-artagnon@gmail.com> <20130419102207.GF2278@serenity.lan>
 <CALkWK0kbXSfghZ69qypfaFF8orWy-bZLRPXcV5WMc5YQ=-18GA@mail.gmail.com> <20130419112524.GH2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Apr 19 13:30:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UT9WW-0000CU-9K
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 13:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968144Ab3DSLa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 07:30:27 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:53761 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968123Ab3DSLa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 07:30:26 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so3250379iee.34
        for <git@vger.kernel.org>; Fri, 19 Apr 2013 04:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BHZhXcCev9xwcEJbuuBXo80ddyzYbHc5KmSCdLjeqkM=;
        b=0CbsE6KO0MFqsD2mJj9xMhYYatsypX1PHWjPNoflGjPNFCpxa4yPN/+nfQK0lnnsuW
         DCXlbfaOPwVc8/8zdVzaucR19qEq+GLCcYvjZATmoBJdVuA52mMry9Upg+nilIYmM3Y7
         mqaUCnwc+n59ZSrqM8Ht8Eg0ZugyEAXdwGXRxY/nd9n1RNPszf2GAXyP9+/721654Aj7
         jOvfVu20iVtKbuOZMQqRO641FdS1pXbON9ost33WtjpoM3GQ/ZTuzsCjKvAjKN9RREaT
         JFJY0u4N8Zd8610daPPDJvPScTKjj4rcxhRO7N3SXlYq92LCsdvWCgs3eEExBg8xPmtl
         Y2fA==
X-Received: by 10.43.9.68 with SMTP id ov4mr7846209icb.22.1366371026435; Fri,
 19 Apr 2013 04:30:26 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Fri, 19 Apr 2013 04:29:46 -0700 (PDT)
In-Reply-To: <20130419112524.GH2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221758>

John Keeping wrote:
> It looks to me like setup_git_directory() returns NULL if we're at the
> top of the working tree so we do need that check.  I suspect that's so
> that "!prefix" does the right thing.

Ah, yes.  My bad.  I expected it to return "/" on the toplevel
directory actually.
