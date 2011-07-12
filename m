From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 09/17] revert: Don't create invalid replay_opts in
 parse_args
Date: Tue, 12 Jul 2011 13:29:58 -0500
Message-ID: <20110712182958.GE14120@elie>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-10-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 20:30:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qghip-0002t9-4X
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 20:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754818Ab1GLSaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 14:30:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47182 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754759Ab1GLSaH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 14:30:07 -0400
Received: by vws1 with SMTP id 1so3665022vws.19
        for <git@vger.kernel.org>; Tue, 12 Jul 2011 11:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TFaUdpJ6uXjlwWGjgfAnewUEN0/5OTFHz36bU6VtLE0=;
        b=nv10LL+2ABVuYJvtCVE1jbiq0fHvmR8iZNVfG8lTEveNqGIYwZI+9kJut0qEiBgJjq
         q1Q3RfTowgSyVpbD3adMKwJv/Ca5lCQXPNLTV4O/boSKDnIHpnq0Fgi+0OBLt4FOmSvy
         O1fL3op6e2wH2ces5C3gjXfWkiAfXWyvJcrlI=
Received: by 10.52.95.46 with SMTP id dh14mr347046vdb.60.1310495407047;
        Tue, 12 Jul 2011 11:30:07 -0700 (PDT)
Received: from elie (adsl-69-209-70-6.dsl.chcgil.sbcglobal.net [69.209.70.6])
        by mx.google.com with ESMTPS id cf7sm5103058vdb.2.2011.07.12.11.30.04
        (version=SSLv3 cipher=OTHER);
        Tue, 12 Jul 2011 11:30:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1310396048-24925-10-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176965>

Ramkumar Ramachandra wrote:

> The "--ff" command-line option cannot be used with four other
> command-line options.

The above sounds like --ff is a bit of a diva and does not like to
be on a commandline with argc >= 6.  But I get the idea.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
