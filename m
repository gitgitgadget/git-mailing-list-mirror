From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [GSoC update] git-remote-svn: Week 10
Date: Wed, 7 Jul 2010 22:24:26 +0200
Message-ID: <20100707202426.GD16065@debian>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Stefan Sperling <stsp@elego.de>,
	Mark Phippard <mphippard@collab.net>,
	Will Palmer <wmpalmer@gmail.com>,
	Julian Foad <julian.foad@wandisco.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: dev-return-4866-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 22:23:13 2010
Return-path: <dev-return-4866-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4866-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWb9F-0006UD-IC
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 22:23:13 +0200
Received: (qmail 85606 invoked by uid 500); 7 Jul 2010 20:23:11 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 85598 invoked by uid 99); 7 Jul 2010 20:23:11 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 20:23:11 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.43 as permitted sender)
Received: from [209.85.215.43] (HELO mail-ew0-f43.google.com) (209.85.215.43)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 20:23:02 +0000
Received: by ewy1 with SMTP id 1so35196ewy.16
        for <dev@subversion.apache.org>; Wed, 07 Jul 2010 13:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uH7YJM+4OyOSsnJ+bbdlOdvVHGZKnO7iUPbtZckPkOE=;
        b=R6bATPl+/YcIi1tqqrSYrLunXyA9JH8DulGxy/C7CmuPE1Ab0Y+MFdugzD5Tno22U7
         uiMXjA/P4aH1d9+BlQrZcEJ3/2vI60/4hNjDhuSzJv9jXZ9mmS8K3XtX0OXdzo13FGY6
         FiAxPFyXsBbOM5jsNywJy0Bq3+ZWMeozQXoUA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CKFrTZ5ff/xv+yzqWyQuAxeuEXFQg1YfkjIvgA3meAGPUfWlKe+c+3IyOsbeYGM7qX
         fJkpcBgK1/ZjoCfmTwzJuszHGVD31Xh6/t/sdzmi5gw+H/T/oKipwWgNWbYrj46cSb1f
         pI3xuvmgxs459LVjk+VDnaipreaHNTYMSdrH0=
Received: by 10.213.7.16 with SMTP id b16mr5925634ebb.34.1278534162391;
        Wed, 07 Jul 2010 13:22:42 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id z55sm64242761eeh.3.2010.07.07.13.22.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:22:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150499>

Hi,

Ramkumar Ramachandra writes:
> Please note that it has been built and tested only against the
> Subversion trunk: for Subversion 1.6, you can try using my
> ra-svn-1.6. Also, there seems to be some unresolved issue on 64-bit
> systems. We're working on fixing this.

This is fixed. I'm currently running a large validation on Avar's
server.

NOTE to reviewers: The must_dump_props and dump_props_pending
variables in patches 7-12 are very confusing. I've fixed this and
added a long explanatory note in the latest commits. Please ignore it
for the moment and review the rest of the series.

-- Ram
