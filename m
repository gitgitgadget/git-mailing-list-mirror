From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git log: Add a switch to limit the number of displayed lines
 from the commit messages
Date: Sun, 16 Jun 2013 23:18:52 -0700
Message-ID: <20130617061852.GA6942@elie.Belkin>
References: <1371319623.9845.34.camel@mattotaupa>
 <20130615191905.GA3363@elie.Belkin>
 <7vd2rlic2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Menzel <paulepanter@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 08:19:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoSmc-0007EV-51
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 08:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755925Ab3FQGTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 02:19:07 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:56058 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932151Ab3FQGTD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 02:19:03 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so2428926pdj.38
        for <git@vger.kernel.org>; Sun, 16 Jun 2013 23:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VRri6mxGcDv9c//oVLwg1OcQYGLN6K3c4PYFHtDiP/w=;
        b=RxeNChyOC0HNAQlLmHCplq72AhpKmdemJUd7soyqQC4nUomGGiv0oaCQZyLAId4q0f
         fZVLkdwUxfBttftvTppZ5dt+8qkqRgwKqmTJzv9eUcn4YvuL13aySyWj+WbxWHLo+G74
         q+fIc0eRo+u60pMLxmnvjHs0yLL6Uf5hwwCNRNc3Sk9hS+GgCretJGZRbWdruHy0Exhh
         13pBTDmVKAlPdxTbtzFy/6JF1dKVVc8DgT5epzONJOcxKMmRYsWVbUTmQX0wl9BxVX3I
         VxKIPqL9J5mRrAUPNhLCqsMV196L2rfgyW7KrUuz8jyukvRkh5il7vbpp3cfUyF5MzwS
         KoLg==
X-Received: by 10.66.147.167 with SMTP id tl7mr11598471pab.40.1371449942193;
        Sun, 16 Jun 2013 23:19:02 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ix3sm12532862pbc.37.2013.06.16.23.19.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Jun 2013 23:19:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vd2rlic2q.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228047>

Junio C Hamano wrote:

> Or inside "less" that is spawned by "git log -p", I often say this:
>
>     /^commit .*|^diff --git .*<ENTER>
>
> and navigate with 'n' and 'p'.

Hm, that implies an interesting trick.  If I run

	LESS='FRSX +/^commit |^diff --git ' git log -p

then 'n' and shift+'n' can be used for navigating without having to
spell out the /pattern to start by hand.
