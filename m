X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla, git and Windows
Date: Mon, 27 Nov 2006 11:13:10 -0500
Message-ID: <9e4733910611270813g4ff982b0tbe6b57d1d49ca9f7@mail.gmail.com>
References: <9e4733910611270728p36e58e08w6cc7a2989b7843ce@mail.gmail.com>
	 <456B057E.4000904@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 27 Nov 2006 16:13:56 +0000 (UTC)
Cc: "Git Mailing List" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L+JQcbSgb4r8fhTrj8SQciJAFRby1WxVe5W4pkQf5+QN3Piq+9lZmZShlnC9vXPStZARn8Q3dTJW/RNNUQ1GmaAmv8ESVru8IluyFJpcQIwcI0Ogaz6Tjon6tPgj3U75Ww9IMc7gLbpoUT46z2V8pj+qyzOjCNMhPizioJdVGjI=
In-Reply-To: <456B057E.4000904@shadowen.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32424>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Goj6l-0002Su-6z for gcvg-git@gmane.org; Mon, 27 Nov
 2006 17:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757090AbWK0QNN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 11:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758352AbWK0QNN
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 11:13:13 -0500
Received: from nz-out-0102.google.com ([64.233.162.206]:52000 "EHLO
 nz-out-0102.google.com") by vger.kernel.org with ESMTP id S1757090AbWK0QNL
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 11:13:11 -0500
Received: by nz-out-0102.google.com with SMTP id s1so692637nze for
 <git@vger.kernel.org>; Mon, 27 Nov 2006 08:13:10 -0800 (PST)
Received: by 10.35.66.13 with SMTP id t13mr13498691pyk.1164643990580; Mon, 27
 Nov 2006 08:13:10 -0800 (PST)
Received: by 10.35.72.13 with HTTP; Mon, 27 Nov 2006 08:13:10 -0800 (PST)
To: "Andy Whitcroft" <apw@shadowen.org>
Sender: git-owner@vger.kernel.org

On 11/27/06, Andy Whitcroft <apw@shadowen.org> wrote:
> Jon Smirl wrote:
> > In the other thread we are discussing the conversion of Mozilla CVS to
> > git format. This is something that has to be done but it is not the
> > only issue. Without a native Windows port they won't even consider
> > using git. There is also the risk that the features needed by Mozilla
> > will be completed after they choose to use a different SCM.
> >
> > Even if we implement all of the needed features git still needs to win
> > the competition against the other possible choices. The last I heard
> > the leading candiate is SVN/SVK.
>
> Do we need to worry too much about taking over the world in one day?
> Yes of course git is _the_ superior solution etc, but too many new users
> at once is always painful.
>
> I think you are more likely to win letting them convert over to SVN.
> From there people naturally start using git mirrors from the SVN trunk.
>  Cirtainly I have two projects which do not use git, one in CVS and one
> in SVN.  I just svnimport that and work in git.  I am confident with
> time the project will migrate, but I am happy other git users are happy
> all without it being the tool of choice.

The SVN version of the Mozilla repository is about 3GB. It takes
around a week of CPU time for svnimport to process it.

-- 
Jon Smirl
