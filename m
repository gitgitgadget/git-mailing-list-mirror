From: Eli Barzilay <eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org>
Subject: Re: [git] Re: Bug in git-stash(.sh) ?
Date: Fri, 4 May 2012 18:36:42 -0400
Message-ID: <20388.23034.73009.601819@winooski.ccs.neu.edu>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
	<87wr4za9mr.fsf@gmail.com>
	<m2pqasb8mr.fsf@linux-m68k.org>
	<xmqqvckk93ta.fsf@junio.mtv.corp.google.com>
	<CALO-gut4csy5wef4iGPGD5jVPc1f0iFBfS3MUWrOwc2yczdviw@mail.gmail.com>
	<20380.33897.666338.766096@winooski.ccs.neu.edu>
	<20120429220132.GB4491@sigill.intra.peff.net>
	<20381.49180.329586.983166@winooski.ccs.neu.edu>
	<20120501134254.GA11900@sigill.intra.peff.net>
	<20386.53745.200846.115335@winooski.ccs.neu.edu>
	<20120504052106.GA15970@sigill.intra.peff.net>
	<20388.9885.608325.489624@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Jeff King <peff-AdEPDUrAXsQ@public.gmane.org>, Yann Hodique <yann.hodique-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Andreas Schwab <schwab-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Junio C Hamano <gitster-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
X-From: magit+bncCOHCzKWgHRD_s5H9BBoEaLAy1A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org Sat May 05 00:36:50 2012
Return-path: <magit+bncCOHCzKWgHRD_s5H9BBoEaLAy1A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Envelope-to: gcvgm-magit-3@m.gmane.org
Received: from mail-ob0-f186.google.com ([209.85.214.186])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <magit+bncCOHCzKWgHRD_s5H9BBoEaLAy1A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>)
	id 1SQR7I-0004pl-Jf
	for gcvgm-magit-3@m.gmane.org; Sat, 05 May 2012 00:36:48 +0200
Received: by obbuo13 with SMTP id uo13sf4273120obb.3
        for <gcvgm-magit-3@m.gmane.org>; Fri, 04 May 2012 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:from:mime-version:message-id:date:to
         :subject:in-reply-to:references:x-mailer:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :x-google-group-id:list-post:list-help:list-archive:sender
         :list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=v6SwUAu6wZip5FnjhqZ3KZNiekbMHt/lbToeg4IJyss=;
        b=Sas9gFtNiUDhFNURvr9z6kMjMRANF+AO514OjBkPWhp2S2RQplJBhAybKGvZ/8m0/K
         Y+7/6xfxRNKcavfSqAyej9u0SqXP8L/FP6bGB5tUKAkbSyyCC6MwjObtmXvPX5NPxCvC
         nbBV5JxvzFCRPSgDBkfoZLK9o8kCGfFvRZQLs=
Received: by 10.50.154.130 with SMTP id vo2mr573563igb.1.1336171007440;
        Fri, 04 May 2012 15:36:47 -0700 (PDT)
X-BeenThere: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Received: by 10.50.181.201 with SMTP id dy9ls1242383igc.1.gmail; Fri, 04 May
 2012 15:36:46 -0700 (PDT)
Received: by 10.42.110.75 with SMTP id o11mr6062638icp.6.1336171006885;
        Fri, 04 May 2012 15:36:46 -0700 (PDT)
Received: by 10.42.110.75 with SMTP id o11mr6062637icp.6.1336171006876;
        Fri, 04 May 2012 15:36:46 -0700 (PDT)
Received: from winooski.ccs.neu.edu (winooski.ccs.neu.edu. [129.10.115.117])
        by gmr-mx.google.com with ESMTPS id md3si118297igc.1.2012.05.04.15.36.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 May 2012 15:36:46 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates 129.10.115.117 as permitted sender) client-ip=129.10.115.117;
Received: from winooski.ccs.neu.edu (localhost.localdomain [127.0.0.1])
	by winooski.ccs.neu.edu (8.14.4/8.14.4) with ESMTP id q44MailV022951;
	Fri, 4 May 2012 18:36:44 -0400
Received: (from eli@localhost)
	by winooski.ccs.neu.edu (8.14.4/8.14.4/Submit) id q44MahHJ022947;
	Fri, 4 May 2012 18:36:43 -0400
In-Reply-To: <20388.9885.608325.489624-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org>
X-Mailer: VM 8.2.0a under 23.2.1 (x86_64-redhat-linux-gnu)
X-Original-Sender: eli-oSK4jVRJLyZg9hUCZPvPmw@public.gmane.org
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 best guess record for domain of eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org designates
 129.10.115.117 as permitted sender) smtp.mail=eli-a5nvgYPMCZcx/1z6v04GWfZ8FUJU4vz8@public.gmane.org
Precedence: list
Mailing-list: list magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org; contact magit+owners-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-ID: <magit.googlegroups.com>
X-Google-Group-Id: 752745291123
List-Post: <http://groups.google.com/group/magit/post?hl=en_US>, <mailto:magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:magit+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/magit?hl=en_US>
Sender: magit-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:magit+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/magit/subscribe?hl=en_US>, <mailto:googlegroups-manage+752745291123+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197079>

Four hours ago, Eli Barzilay wrote:
> 
> I can still make a proper patch with the fix for git-stash.sh that
> avoids the problem with the spaces.

Here's another idea for an easier patch that instead of fixing the
issue with space just spits out a better error: before throwing the
"Too many revisions specified" error, check if "$*" matches "{.*}"
and if "$1" matches "{[^}]*" and in that case make the error say that
spaces are not supported.  The change is therefore only in the error,
and with a fixed output, that should be enough.

(Please tell me if the above or this is desirable...)

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
