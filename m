From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH v2] revision.c: really honor --first-parent
Date: Wed, 14 May 2008 12:54:32 +0200
Message-ID: <8c5c35580805140354s62301343n62f8319b1853bfbd@mail.gmail.com>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com>
	 <1210605156-22926-1-git-send-email-hjemli@gmail.com>
	 <20080513201522.GA11485@cuci.nl>
	 <8c5c35580805131343kc115df6yd7ce3281fb3e6171@mail.gmail.com>
	 <7vej85suc2.fsf@gitster.siamese.dyndns.org>
	 <20080514103454.GA28610@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, nanako3@bluebottle.com,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Wed May 14 12:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwEdu-0008L9-GI
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 12:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755955AbYENKyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 06:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbYENKyk
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 06:54:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:39033 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612AbYENKyj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 06:54:39 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1830537ywe.1
        for <git@vger.kernel.org>; Wed, 14 May 2008 03:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MhEuXtpUt4JUOP+CMv3IdJrl55P4OgBF8qGlQN4+QEs=;
        b=P1AGrbKXYbIFg/TpNv/N3/W0iNPvelGXU93b9xpA8NEPEM7KTHmt8G/aNWlFGRt64F37GONULJy95dmwwB6tmdb2cv02uibtY04pKP+ISmkp8kExSS394VeGq9IKhrRqsoslbNl3A+dQySNp8/IvTjlr8tJl5VRue6qxHmqYAXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EuDTcpXKWfvBvKbMq6W8Z7HP7HL6qXms1SkDST3pX5qY1E7M0u8xmHQhA8pJWazP07VM3aHZuy6R2R+jgZYnjUWylDK/5RlZG7Y0zfM/ZZTA2jH6NUHi5c2kLWLW5/wicU8xBnRD9m3W/l7gQQ5pw7Z3wpqFA0EMy20dUihnH1Q=
Received: by 10.150.68.2 with SMTP id q2mr851772yba.86.1210762472080;
        Wed, 14 May 2008 03:54:32 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Wed, 14 May 2008 03:54:32 -0700 (PDT)
In-Reply-To: <20080514103454.GA28610@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82095>

On Wed, May 14, 2008 at 12:34 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>  So, I'd say, since the current code does not and cannot work reliably
>  for anyone specifically using --first-parent (with every merge
>  encountered, the probability of correctness is multiplied by 0.5 at
>  most/least), you are going to do them a favour anyway by fixing the code,
>  then why not simplify the convolution and make the code rock-steady (and
>  implement my patch)?

The current 'next' branch in git.git contains your patch with my fixup
on top and I believe this fixes _both_ the original issue with
first-parent (thanks to your patch) and the issue Nanako discovered
(thanks to my patch). Am I missing something?

-- 
larsh
