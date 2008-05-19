From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Re* [PATCH] "not uptodate" changed to "has local changes"
Date: Mon, 19 May 2008 20:28:26 +0200
Message-ID: <bd6139dc0805191128t13afc8ard051138083e2b694@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <1ED37CF1-EABD-4881-BA29-ED2CB1CE73FC@sb.org>
	 <b8bf37780805162030m4c961505nabd72e8f5bd08404@mail.gmail.com>
	 <alpine.DEB.1.00.0805171102480.30431@racer>
	 <e06498070805170744l7ad213aeqb779b0c0381e1de4@mail.gmail.com>
	 <bd6139dc0805170912w14b7894fxfebe15c14e4c44ef@mail.gmail.com>
	 <7v63tcda7e.fsf_-_@gitster.siamese.dyndns.org>
	 <D925ECD3-1EE2-48EB-B1E5-2604C10AD643@wincent.com>
	 <7vzlqm89tj.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Wincent Colaiuta" <win@wincent.com>,
	"Steven Walter" <stevenrwalter@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Kevin Ballard" <kevin@sb.org>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 19 20:29:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyA6q-0004RF-Ak
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 20:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753398AbYESS23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 14:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752745AbYESS23
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 14:28:29 -0400
Received: from rn-out-0910.google.com ([64.233.170.185]:37970 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbYESS22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 14:28:28 -0400
Received: by rn-out-0910.google.com with SMTP id e11so507751rng.17
        for <git@vger.kernel.org>; Mon, 19 May 2008 11:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UMP0WVfmGKnjjPDC+VuM14mUlO4XBM4bXewrBZP9Csc=;
        b=pXtjj6D2o9uMirpDej3hBI+Gpwg4uAPXLBsa5UIR/GFnKyLWM89d43zCdORLWxNoAwrKS3DWyE232stzt1I5rbTHYsXcwdKRWdn4lZYxIwYHAJrgyiOKvP2eUcyHN3BdO8OL5oLQd2H8TwQBu5lT5xMw4MeEYhqduoT6faBlqwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=P6OMrdtVN5kqfuNUWEFlLbny2VzugEK+mjnRVJnhstd/ZnqJWdeeOj/4hSE36belpvVUQGYnqvO4iuIdS84ZpFRU/G5WE0w+ES0FEd5cNohYWQ0buqiShedoiN0Vzh5wTWKHDn/cM6V8dL8X7ModARM2VBX+xlvguFaI9aBRo50=
Received: by 10.142.99.21 with SMTP id w21mr2967179wfb.55.1211221706773;
        Mon, 19 May 2008 11:28:26 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Mon, 19 May 2008 11:28:26 -0700 (PDT)
In-Reply-To: <7vzlqm89tj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82439>

On Mon, May 19, 2008 at 7:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Why does *everybody* keep missing the whole point of this patch?

Isn't it to make it possible to change the error messages at porcelain
level while allowing the plumbing to remain backward compatibility?

-- 
Cheers,

Sverre Rabbelier
