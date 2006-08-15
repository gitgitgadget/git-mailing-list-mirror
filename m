From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: configurable home link string
Date: Tue, 15 Aug 2006 21:36:43 +0200
Message-ID: <8fe92b430608151236l35ff169cjea6580250182b5ef@mail.gmail.com>
References: <11555958491891-git-send-email-yashi@atmark-techno.com>
	 <ebsrsn$tgq$1@sea.gmane.org> <20060815192737.GA14459@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 21:37:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD4iX-0006vj-Qe
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 21:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWHOTgr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 15:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030474AbWHOTgr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 15:36:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:26705 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030470AbWHOTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 15:36:46 -0400
Received: by nf-out-0910.google.com with SMTP id x30so428822nfb
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 12:36:44 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=beZB82sCXHJQTd5R2ejCOBk3CJu3vryl3blY8zrpVGQUwKd1sRdF36o5DytRWNyAHj/1H9SdAyoUaOnmnUpSKQx/1wLp4mLMpnV4voYMPuRWVmotI/HRZS9WC46obgdBh5hincDcXllBv4NEp01kPLaB0Yy4Ej2AIX4PV1bdqeM=
Received: by 10.49.8.4 with SMTP id l4mr1765367nfi;
        Tue, 15 Aug 2006 12:36:43 -0700 (PDT)
Received: by 10.78.128.20 with HTTP; Tue, 15 Aug 2006 12:36:43 -0700 (PDT)
To: "Martin Waitz" <tali@admingilde.org>
In-Reply-To: <20060815192737.GA14459@admingilde.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25476>

On 8/15/06, Martin Waitz <tali@admingilde.org> wrote:
> On Tue, Aug 15, 2006 at 06:15:05PM +0200, Jakub Narebski wrote:
>> There is similar improvement in gitweb-xmms2, where the git clone/fetch
>> URL for an individual project is visible in the "summary" page for project,
>
> doesn't it make more sense to make it more easy to use the same URL for
> git:, http: and gitweb?

It is not always possible to use the same URL for gitweb and http://
access, for example gitweb might require /cgi-bin/ in path. git:// and
git+ssh:// access migh need different path than http:// access.

With PATH_INFO for 'project' parameter actually used gitweb link would
be the same as http:// access link; the problem would be to
differentiate which handle using gitweb.cgi, and which handle
directly.
-- 
Jakub Narebski
