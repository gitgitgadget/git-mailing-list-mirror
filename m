X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: New improved patchset view
Date: Wed, 8 Nov 2006 20:04:19 +0100
Message-ID: <200611082004.19918.jnareb@gmail.com>
References: <200611081147.52952.jnareb@gmail.com> <7virhpu73w.fsf@assigned-by-dhcp.cox.net> <7vejsdu5p5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 8 Nov 2006 19:04:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HJv3EIJxXeGcYBAOf/bk9CAgrmiMXO4vqFfsnUHfTMMgsxWiXy0C82D3bLdlRD9KNOlSDJgAzvFTmWwKXJCAFWCsWQWMX6pklpNNQdiDg3x8ZGp9VoiWhyX55rVprorrKUZeEyYjSKvi9Ixpyf/zlc65OiH5m0Oqj1A3asMXUHA=
User-Agent: KMail/1.9.3
In-Reply-To: <7vejsdu5p5.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31154>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ghsi7-000126-0r for gcvg-git@gmane.org; Wed, 08 Nov
 2006 20:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161686AbWKHTDk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 14:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161690AbWKHTDk
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 14:03:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:21155 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161686AbWKHTDj
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 14:03:39 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1611321ugc for
 <git@vger.kernel.org>; Wed, 08 Nov 2006 11:03:36 -0800 (PST)
Received: by 10.67.103.7 with SMTP id f7mr11451245ugm.1163012616008; Wed, 08
 Nov 2006 11:03:36 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id w40sm7417436ugc.2006.11.08.11.03.35; Wed, 08 Nov
 2006 11:03:35 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > Jakub Narebski <jnareb@gmail.com> writes:
> >
> >> ---
> >>  gitweb/gitweb.css  |   66 +++++++++++++++----
> >>  gitweb/gitweb.perl |  183 
> >> ++++++++++++++++++++++++++++++++++------------------
> >>  2 files changed, 173 insertions(+), 76 deletions(-)
> >
> > Linewrap?
> >
> >> 
----------------------------------------------------------------------
> >>  ## functions returning short HTML fragments, or transforming HTML 
> >> fragments
> >
> > ...
> 
> No need to resend -- will manage.

Too late... ;-)

-- 
Jakub Narebski
