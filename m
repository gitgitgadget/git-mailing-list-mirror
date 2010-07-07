From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 02/13] Add skeleton SVN client and Makefile
Date: Wed, 7 Jul 2010 22:47:02 +0200
Message-ID: <20100707204702.GE16065@debian>
References: <1278461693-3828-1-git-send-email-artagnon@gmail.com>
 <1278461693-3828-3-git-send-email-artagnon@gmail.com>
 <20100707162516.GA1529@burratino>
 <20100707170926.GC18806@debian>
 <20100707193017.GA2911@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, dev@subversion.apache.org,
	Stefan Sperling <stsp@elego.de>,
	Julian Foad <julian.foad@wandisco.com>,
	Will Palmer <wmpalmer@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: dev-return-4867-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 07 22:45:50 2010
Return-path: <dev-return-4867-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-4867-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OWbV8-0002Xq-Em
	for gcvsd-dev@lo.gmane.org; Wed, 07 Jul 2010 22:45:50 +0200
Received: (qmail 21463 invoked by uid 500); 7 Jul 2010 20:45:48 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 21455 invoked by uid 99); 7 Jul 2010 20:45:48 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 20:45:48 +0000
X-ASF-Spam-Status: No, hits=0.0 required=10.0
	tests=FREEMAIL_FROM,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: domain of artagnon@gmail.com designates 209.85.215.43 as permitted sender)
Received: from [209.85.215.43] (HELO mail-ew0-f43.google.com) (209.85.215.43)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 07 Jul 2010 20:45:39 +0000
Received: by ewy1 with SMTP id 1so41946ewy.16
        for <dev@subversion.apache.org>; Wed, 07 Jul 2010 13:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=f389/s6FHVMx89hEqad4Xwn1gRBMeCRVOhPE03RCV18=;
        b=aJAC3NihpysCtxyva67nvu+W8TsRVq0kMCHM1OvS52JLZEkyAvxTFoE4e2hErzkhY8
         iui7qCT5IvcQ4ZIhiV9iO1ReVqj9kYfOzb/mukQzOoVSvx8wcHyKZaUkE1IUaHqDu9UW
         uBqCXCIKJNzjqOcV9hP4L/YfHxO82hqg5nZy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Yu8leS6UdZ1tblqpFm4O2K6Ah7eMHcOxeswpF1lpLKnrVq5rNrVv9mh73Wd10+oi5T
         qLRWQvmxQ64cJk9s304rgBit4T2YTXvQZRJxj2fG+b/EJtbPW8xN8uS/l6QZWSRMkQMf
         qLSXR34Zvn98Fyzc7oCEDwaw6OXtnflH3p+RE=
Received: by 10.213.27.68 with SMTP id h4mr6273764ebc.67.1278535518964;
        Wed, 07 Jul 2010 13:45:18 -0700 (PDT)
Received: from debian (adm12-98.itu.dk [130.226.133.98])
        by mx.google.com with ESMTPS id a48sm64363304eei.19.2010.07.07.13.45.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 07 Jul 2010 13:45:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100707193017.GA2911@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150504>

Hi,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
> 
> > Here's a diff of the modifications I made after your review:
> 
> That’s quite helpful.
> 
> > +++ b/svndumpr.c
> > @@ -76,31 +76,19 @@ static svn_error_t *replay_revend(svn_revnum_t revision,
> [...]
> > +	/* Populte ctx->auth_baton with the auth baton
> > +	   non-interactively. Arguments 3, 4 and 5 are for username,
> > +	   password and config_dir which is NULL in this case. Set
> > +	   no_auth_cache and trust_serv_cert to FALSE, don't provide a
> > +	   config, and omit cancel_func/ cancel_baton */
> >  	SVN_ERR(svn_cmdline_create_auth_baton(&(ctx->auth_baton), TRUE,
> >  					      NULL, NULL, NULL, FALSE,
> >  					      FALSE, NULL, NULL, NULL,
> 
> I think you took my suggestion too seriously here.  Such a comment
> probably will not help people much; instead, maybe a more focused
> comment can help the curious avoid looking up
> svn_cmdline_create_auth_baton:
> 
> 	/* Default authentication providers for noninteractive
> 	   use. */
> 	SVN_ERR(svn_cmdline_create_auth_baton(...

Fixed.

> Looking this up, I notice that function was added in svn 1.6.
> Hopefully that is okay, since this code is destined for svn trunk.

I have a working 1.6 fork now that I intend to merge into
git.git. When there's a new release of Subversion that includes my
patch, I'll remove it from git.git.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

-- Ram
