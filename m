From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH] "not uptodate" changed to "has local changes"
Date: Fri, 16 May 2008 13:50:39 +0200
Message-ID: <38b2ab8a0805160450s495aceddy3335d27f076aa64e@mail.gmail.com>
References: <1209833972-12256-1-git-send-email-timcharper@gmail.com>
	 <b8bf37780805151914j65ce5406xc5e6b3d29e3bfb9b@mail.gmail.com>
	 <alpine.DEB.1.00.0805161125320.30431@racer>
	 <200805161302.47865.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"=?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?=" <andre.goddard@gmail.com>,
	"Mike Ralphson" <mike.ralphson@gmail.com>,
	"Tim Harper" <timcharper@gmail.com>
To: "Holger Schurig" <hs4233@mail.mn-solutions.de>
X-From: git-owner@vger.kernel.org Fri May 16 13:51:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwyTL-0007fX-Mg
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 13:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbYEPLul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 07:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbYEPLul
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 07:50:41 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:38313 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYEPLuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 07:50:40 -0400
Received: by rv-out-0506.google.com with SMTP id l9so143926rvb.1
        for <git@vger.kernel.org>; Fri, 16 May 2008 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=jT2q//woyuvCQpmi+J49D2QbDVAsUmn4NXNRFgHO3bo=;
        b=lOTSR8xjd5dFGLc4ITYdJC1HBPhlmubITupzeFI7uB1XGgFeEwfcw1rKSMUWHUa40lx1fWJk92KVBxMteN92pl50mGMMxDHz+XCP6/U641FlJ+Tsj/en32Owei8SCdH+zuGzbcEC1jVWizfGVVUsFg0JBu3QAgPJqn756Awb378=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FPfQWjFzlo4S+5O8AGfRscAwk7T7h+lETuahcJihlEn6B7bZuOS4Nc+enBWuhdNKrctzYE+O3/VxtBMGJAWv66njnbkbmagHCvjZHNTZKo2anVJ2o/syhhDoPawfJTv+5docb+k1jBLELUbimSdaFVhysUfk1BCV9BuaTHz4TLU=
Received: by 10.141.87.13 with SMTP id p13mr1743377rvl.62.1210938639670;
        Fri, 16 May 2008 04:50:39 -0700 (PDT)
Received: by 10.140.147.1 with HTTP; Fri, 16 May 2008 04:50:39 -0700 (PDT)
In-Reply-To: <200805161302.47865.hs4233@mail.mn-solutions.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82277>

On Fri, May 16, 2008 at 1:02 PM, Holger Schurig
<hs4233@mail.mn-solutions.de> wrote:
>> No comment on the concern that it might break people's
>> scripts?  None?
>
> Scripts should look for exit values :-)

except that they're not documented ;)

-- 
Francis
