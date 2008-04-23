From: "Benjamin Collins" <ben.collins@acm.org>
Subject: Re: git-gui hangs on read
Date: Wed, 23 Apr 2008 09:16:39 -0500
Message-ID: <b3889dff0804230716n1b5dde1ctb7b0c1dd83f2d1ff@mail.gmail.com>
References: <b3889dff0804210723s620363fdscba43c79dbb62d55@mail.gmail.com>
	 <20080422001311.GS29771@spearce.org>
	 <b3889dff0804220634u58a5ed21yf8a4f369471c6534@mail.gmail.com>
	 <20080422232530.GK29771@spearce.org> <480EF84A.4020308@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Gustaf Hendeby" <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Wed Apr 23 16:17:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jofmp-0005V6-RU
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 16:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbYDWOQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 10:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbYDWOQl
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 10:16:41 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:2121 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYDWOQk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 10:16:40 -0400
Received: by py-out-1112.google.com with SMTP id u52so4226335pyb.10
        for <git@vger.kernel.org>; Wed, 23 Apr 2008 07:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=8aHJOt6gLWshoBWKluHbjCJkAHiDSireybOonF1H7Po=;
        b=Dq/kGj8iZoaBo1Zjc8dUh8gSN1Z3t3m8Lc3qxU9HUJAqTEMvvzJqVfv6ueYFXIqMTPtw340wteOupM3wMiOHMvYhcNxZZws4/lGZ9Cqg3C0qNB9C3Zo13XdAFsTxAy6VXQ8laqYjYDNC8GvA26k/ZhhC4Q2zUT4h6kKX5+4BvQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iwmUnf2Vh20pUqFzOFOy0CNultD+wf/VabejhNtWfIRXNhlvwiksjvz4ZWIx6q+STvsr2ftExSeMzz3BDRIjm+MidHH1YqLZKdXk8AUDt0FaBOZn/PJvyagOyu8h/gXs9VBcHHuXnSXPfgXiv/iFINzbLj6y23vnSA7A/pwqt9Q=
Received: by 10.141.122.20 with SMTP id z20mr550233rvm.160.1208960199484;
        Wed, 23 Apr 2008 07:16:39 -0700 (PDT)
Received: by 10.141.75.14 with HTTP; Wed, 23 Apr 2008 07:16:39 -0700 (PDT)
In-Reply-To: <480EF84A.4020308@isy.liu.se>
Content-Disposition: inline
X-Google-Sender-Auth: dff4f3afb86ea77d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80220>

On Wed, Apr 23, 2008 at 3:50 AM, Gustaf Hendeby <hendeby@isy.liu.se> wrote:

>  I have aspell 0.50.3 alpha installed on my laptop, and that seems to be
> basically up to date for the Windows port of aspell.  Is there any way to
> get around this problem?
>
>  /Gustaf
>

What I have done for now is to comment out the line in gui-gui that
does the lappend on spell_cmd, near the end.

Sorry for the dupe.

-- 
Benjamin A. Collins <ben.collins@acm.org>
