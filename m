X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: git-show --stat on first commit
Date: Tue, 21 Nov 2006 15:09:13 +0100
Message-ID: <8aa486160611210609h1c2d229ekf0b5e8aeb4f21f11@mail.gmail.com>
References: <200611211341.48862.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 21 Nov 2006 14:09:53 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jnaUTVQuIjQyW07rKfv43mdHTvg9Pvo0GTYt0aLH1hvhCywZlA7FghSVw5b6F4v4/1hGodBhGdVwcx03xUrpGlN6Ej/ThnN+STzWFb+eGAcM53DU703Ct5GH3lyEiUbkMCl1g0694RjcbXn9pyKQNW85FdCE3Npo2B+E/xPo0FE=
In-Reply-To: <200611211341.48862.andyparkins@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31990>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmWJN-0002LY-33 for gcvg-git@gmane.org; Tue, 21 Nov
 2006 15:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030981AbWKUOJP (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 09:09:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030984AbWKUOJP
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 09:09:15 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:62941 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1030981AbWKUOJO
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 09:09:14 -0500
Received: by wx-out-0506.google.com with SMTP id s7so2228892wxc for
 <git@vger.kernel.org>; Tue, 21 Nov 2006 06:09:13 -0800 (PST)
Received: by 10.70.8.20 with SMTP id 20mr3065938wxh.1164118153548; Tue, 21
 Nov 2006 06:09:13 -0800 (PST)
Received: by 10.70.45.1 with HTTP; Tue, 21 Nov 2006 06:09:13 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/21/06, Andy Parkins <andyparkins@gmail.com> wrote:
> Hello,
>
> I'm sure this one will be known about already.  git-show --stat on the the
> first commit doesn't show anything.  I assume it's because git-diff-tree has
> nothing to diff against (although shouldn't that be an everything-new diff?).
>
> Given the above; does anyone have a suggestion for what I could use as a
> replacement?  Even just a list of the new files would be useful.

$ git show --stat --root

In general the initial commit diff (or stat) is hidden, but perhaps it
make sense to show it in "git show", you asked fo this specifically.

