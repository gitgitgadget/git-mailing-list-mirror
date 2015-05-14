From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] http: add support for specifying an SSL cipher list
Date: Thu, 14 May 2015 15:39:20 -0400
Message-ID: <CAPig+cSuMpQjJRPeaeRdeqWkzJ5Jqde0RuU+OwY=npLwHLP_Aw@mail.gmail.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
	<1431091335-16455-1-git-send-email-lars@redhat.com>
	<20150514192552.GB6475@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 14 21:39:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysyyd-0007UC-Bb
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965397AbbENTjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:39:23 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:36789 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965255AbbENTjV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:39:21 -0400
Received: by iepk2 with SMTP id k2so68437202iep.3
        for <git@vger.kernel.org>; Thu, 14 May 2015 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GLJdjdBk4QWajbOH49ZUzR0GN3RmE5rFd0bKOWAc9V8=;
        b=fNuZx4B2wvsZMC7SrcWjE5BS92e+py5ylvFD3yrlLxbylHCV6LLy/l8sHRkaUp/H0o
         wcETZk4G099MPysEi+Zo+ZnueUg53J4gIpdBcU3fqbzeAucpDHsT87PaNl20RS+Peedl
         C1oU3nWZoLea6WcUYUd4MuOrhURgbzOrkt7GXX783A27thV+442C3lAw50Kfvv63MaNX
         CXrry4SUA3hcZ2UPav8nZyyPTrONCQQHCx1ogLKsE5np3H/w+aULd+av/9D7cOVPHJG7
         Xk4hdM9JT5Fg3XPSF/CL3MFl3l1XkAVNucrws+X8O1JuHuJgMiX5qoeiSWSqvCYcMWWx
         0Yuw==
X-Received: by 10.50.61.200 with SMTP id s8mr37415559igr.7.1431632360972; Thu,
 14 May 2015 12:39:20 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 14 May 2015 12:39:20 -0700 (PDT)
In-Reply-To: <20150514192552.GB6475@redhat.com>
X-Google-Sender-Auth: FsjES70C2tX2EgcuBh_V845qqzc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269076>

On Thu, May 14, 2015 at 3:25 PM, Lars Kellogg-Stedman <lars@redhat.com> wrote:
> On Fri, May 08, 2015 at 09:22:15AM -0400, Lars Kellogg-Stedman wrote:
>> Teach git about a new option, "http.sslCipherList", which permits one to
>> specify a list of ciphers to use when negotiating SSL connections.  The
>> setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
>> variable.
>
> I just wanted to follow up and see if folks were happy with the latest
> version of the patch.

Here's what Junio's latest "What's Cooking"[1] says:

    * ls/http-ssl-cipher-list (2015-05-08) 1 commit
     - http: add support for specifying an SSL cipher list

     Introduce http.<url>.SSLCipherList configuration variable to tweak
     the list of cipher suite to be used with libcURL when talking with
     https:// sites.

     Will merge to 'next'.

The "Will merge to 'next'" is explained in [2].

[1]: http://article.gmane.org/gmane.comp.version-control.git/268680/
[2]: http://article.gmane.org/gmane.comp.version-control.git/268100/
