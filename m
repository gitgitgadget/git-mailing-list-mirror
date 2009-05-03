From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for araxis merge
Date: Sun, 3 May 2009 11:20:41 -0700
Message-ID: <20090503182040.GB50640@gmail.com>
References: <1241313481-17923-1-git-send-email-davvid@gmail.com> <200905030854.28059.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, snowcoder@gmail.com, spearce@spearce.org,
	Johannes.Schindelin@gmx.de, git@vger.kernel.org,
	charles@hashpling.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun May 03 20:20:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0gJ6-000337-2e
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 20:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbZECSUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 May 2009 14:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754564AbZECSUs
	(ORCPT <rfc822;git-outgoing>); Sun, 3 May 2009 14:20:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:17390 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754294AbZECSUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 May 2009 14:20:47 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2594678rvb.1
        for <git@vger.kernel.org>; Sun, 03 May 2009 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=cYYH1uAN1pKdkLQ8/voMIjh4YbWugNKFWJl+NON3bUE=;
        b=P3L1oFQy+sCuUQw8qLweRNcl7pU2uSs4x0VEl3DefmDkL5tBvFO1lpGDYATYY3mfbV
         qBU9kkpU2lPhIDdZ6pkJuBcXeIBJkpp52jCr2Q0FEQlf+lz3kL742ONpKTQzC+etpx81
         2hm1x6IWbLc4rRhJLHTv4IciKdUb2+WcUtTQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=q2Txjphy0ccW7hzzDX/olReXwXfi7uCHC4/k3zkMMw4pf1jqECznS3sP8NWbMyy3nY
         +a0fiksZ1onGThn2ddujMs+DB7nhcAa3HasBXUzGPTuCYaJ7kzhYDxyAMGvbWSOz1/jI
         JxremQDRk2aVF6LsgTG9jSVdJUTUEAg4iz1S4=
Received: by 10.115.19.18 with SMTP id w18mr3577523wai.58.1241374846567;
        Sun, 03 May 2009 11:20:46 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id l37sm8545002waf.5.2009.05.03.11.20.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 May 2009 11:20:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905030854.28059.markus.heidelberg@web.de>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118181>

> David Aguilar, 03.05.2009:
> > +				"$merge_tool_path" -wait -merge -3 -a1 \
> > +					"$BASE" "$LOCAL" "$REMOTE" "$MERGED" \
> > +					>/dev/null 2>&1
> > +			else
> > +				"$merge_tool_path" -wait -2 \
> > +					"$LOCAL" "$REMOTE" "$MERGED" \
> > +					>/dev/null 2>&1
> > +			fi
> > +			check_unchanged
> > +		else
> > +			"$merge_tool_path" -wait -2 "$LOCAL" "$REMOTE" \
> > +				>/dev/null 2>&1
> > +		fi
> > +		;;
> 
> Haven't you included the -title[1-3] command line switches because of
> the strange "'title'" format? The user on the msysgit list had commented
> it out in his patch, although he said it worked in this way. And looking
> at git-gui/lib/mergetool.tcl, it is done in the same way.
> 
> Markus
> 

I can resend with the title stuff.
I didn't include it since it was commented out in the original
patch.

-- 
		David
