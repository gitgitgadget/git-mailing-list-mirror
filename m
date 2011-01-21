From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] setup: always honor GIT_WORK_TREE and core.worktree
Date: Fri, 21 Jan 2011 16:05:33 -0600
Message-ID: <20110121220532.GA23695@burratino>
References: <1290785563-15339-40-git-send-email-pclouds@gmail.com>
 <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
 <20110119123732.GA23222@burratino>
 <20110119124230.GD23222@burratino>
 <AANLkTinE5gNZM_HDJq31qs5ARJn-DrO9HW66cszTayPa@mail.gmail.com>
 <20110119193116.GB30618@burratino>
 <7vpqrssl5d.fsf@alter.siamese.dyndns.org>
 <7v39omotxg.fsf@alter.siamese.dyndns.org>
 <7vtyh1oqy8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Maaartin <grajcar1@seznam.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 23:06:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgP7H-0003LB-Bu
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 23:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab1AUWFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 17:05:54 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42708 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752861Ab1AUWFx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 17:05:53 -0500
Received: by vws16 with SMTP id 16so935330vws.19
        for <git@vger.kernel.org>; Fri, 21 Jan 2011 14:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2ed2ToBUJUpaSahaqqbmrdPXWYRSPjN9TUf7rBZgATA=;
        b=v+7EWYQUIhZwnoXx3YT+Q/pTduaUTgvkwXzbBdCwRHnr+4SuXyIlVRx4mfBtQyRL21
         dK2drKKixvJS9/qwcCkF5uunUp/gjK7WtMM/m2dC4miZS8aAhtEWqq6TxRdrJdN+ZiGd
         3BVXxev761Pg57SlOdZjAL4UlDIveAtqaiqfw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=poD8tCnnfcNMIA7CMWkB3Cz50cY/LKpyhnkJVrqwRByTkcCVnvwICEN806h2ydErbu
         HdNQJIpgg1zgn6vvHRVjxlrQXZV336udk309Ryrpe89T6iB8GMvQnDWD0g25ysuZFJrF
         OQAcHlNSTpLUzP2wT8KNMQx6xDmM2ToQPbxsU=
Received: by 10.220.175.134 with SMTP id ba6mr311232vcb.86.1295647553185;
        Fri, 21 Jan 2011 14:05:53 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id y15sm3420307vch.29.2011.01.21.14.05.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 21 Jan 2011 14:05:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vtyh1oqy8.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165398>

Junio C Hamano wrote:

> Perhaps squash this into, or apply on top of, your 3/3?

Looks good to me.  I'd suggest squashing and using your commit
message for the combined commit.
