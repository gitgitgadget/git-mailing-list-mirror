From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git ate my home directory :-(
Date: Mon, 25 Mar 2013 15:15:13 -0700
Message-ID: <20130325221512.GI1414@google.com>
References: <5150C3EC.6010608@nod.at>
 <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <5150CB34.1030008@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Richard Weinberger <richard@nod.at>
X-From: git-owner@vger.kernel.org Mon Mar 25 23:15:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKFgB-0006oM-46
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 23:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758989Ab3CYWPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 18:15:19 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54940 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782Ab3CYWPS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 18:15:18 -0400
Received: by mail-pa0-f46.google.com with SMTP id wp1so1260140pac.33
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 15:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+ZBT+o4HoXs40PvOsi+UzD+IbNTJYczAIJhUmLMZ3sE=;
        b=NukQcEy9DPtvZhu8S1xqiKmhzhnPKmjix7zCBXLKNwsN8qKyasulU1mGvoAGMgtvlz
         +Bwxf0pFbg+/tkpWF+7AP+EFKwAYtZ8nuQPzBcVqrSoxI1jfNVf5vFW1EYOBzhyzg556
         jWmypIzfJlSJVnoXQxHfqSpYyCQBJKpm96tur2Ue7GFcEb0v7ESC/19LzyUfhJIBu9co
         6KYB9iSq04XJtH6AcBd7wruGo+fQXCDxUjgWQx6OUIIrq9zL2TRhm7Mh0rlz/0zf5KwX
         tC5y/i8S2zSTDbtRTFNyAvV7yA1xvGlBKEtFJ/RGz/aEplLZJPZt5JtoBeCM40jf7xoi
         aPBQ==
X-Received: by 10.68.212.33 with SMTP id nh1mr19809865pbc.140.1364249717466;
        Mon, 25 Mar 2013 15:15:17 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id qb10sm14797509pbb.43.2013.03.25.15.15.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 15:15:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5150CB34.1030008@nod.at>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219109>

Richard Weinberger wrote:

> Okay, I have to set GIT_DIR _and_ GIT_WORK_TREE to make my scripts safe again?
> I've always set only GIT_DIR because it just worked (till today...).

chdir-ing into the git repo without setting any GIT_* vars is probably
the simplest way to go.
