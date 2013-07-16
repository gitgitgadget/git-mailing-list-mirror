From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] apply, entry: speak of submodules instead of
 subprojects
Date: Tue, 16 Jul 2013 11:07:39 -0700
Message-ID: <20130716180739.GK14690@google.com>
References: <87bo631odi.fsf@hexa.v.cablecom.net>
 <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 16 20:07:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz9fA-0006ls-4O
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 20:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933411Ab3GPSHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 14:07:44 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:37014 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932868Ab3GPSHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 14:07:43 -0400
Received: by mail-pd0-f171.google.com with SMTP id y14so933269pdi.16
        for <git@vger.kernel.org>; Tue, 16 Jul 2013 11:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=FsnRGe2myDG4mCf+eOAlz0U5n1O9pOzl1ImTMM4m5qw=;
        b=B1e8Yd0o99WEXzdPPa4G6Y9e30rFPERUcVsGlpFDsGC3ShKr7S0f9Vr1BWIiPLpTEW
         acCl/eZSXz6UWGMPsaCxFN8zcNMXluRVRPL9bzlTloloDXfdDXz/cvfWD77HYvbP706D
         uGwXSS7p2r/9LVrmn73BZ9n2giMw9NG4fqvT7zolSCu8zxT92vSHPcfGj2w4BAhCYOLT
         kN8RJfXi5OUfJ3sdJaMcsiWntXR0u/8LGEofuSEhIWIwBvMFmoimvpw/JhUF+gA9BFc5
         qOj9y2WmNq6fB3utGZmGdktcRkdYbmvjsTXfGZ5YoNL3g1//rbxN4/PL+lNer7B99ICc
         3BBQ==
X-Received: by 10.68.59.98 with SMTP id y2mr2681472pbq.135.1373998062783;
        Tue, 16 Jul 2013 11:07:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qv4sm3194545pbc.16.2013.07.16.11.07.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Jul 2013 11:07:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8df0d41caa10a38e46783bebd3148a7b8445dd47.1373966389.git.trast@inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230569>

Thomas Rast wrote:

> There are only four (with some generous rounding) instances in the
> current source code where we speak of "subproject" instead of
> "submodule".  They are as follows:
[...]
> Let's at least change the error messages to consistently call them
> "submodule".
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
> This and the next one are message changes for things I found during my
> review.

Thanks.  It's nice when translation results in the messages in English
being improved, too.

For what it's worth,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
