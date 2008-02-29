From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH 04/40] Windows: Use the Windows style PATH separator ';'.
Date: Fri, 29 Feb 2008 13:45:47 +0100
Message-ID: <47C7FE7B.3030309@gnu.org>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-5-git-send-email-johannes.sixt@telecom.at> <47C67E1A.5030304@gnu.org> <200802282143.19322.johannes.sixt@telecom.at> <47C7BAEE.2020408@gnu.org> <alpine.LSU.1.00.0802291214160.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 13:46:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JV4dB-0004Zd-2N
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 13:46:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755423AbYB2Mpw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 07:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755686AbYB2Mpw
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 07:45:52 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:15204 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754997AbYB2Mpv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 07:45:51 -0500
Received: by fk-out-0910.google.com with SMTP id z23so5314841fkz.5
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 04:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=sDwYsLjsvaYkVmkKekOa8PFzVoSagwE+UloU3PYytFI=;
        b=PeKFljJSWjWufCq6UsyZcbc9fYXbjM3aSPwMGtcREitCobDgvQrbkOkbQgLNrX+RH8vLxFir2CBh87gE6j4Enm2Jv+sthEUlZgOJSpN65rYOxy4XERU+F+4viNTQqVnywLycz6gQPtB6cG2LQGVQfK/z8nHi9jb25VcNafA0ndA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:sender;
        b=rXapnQ78kNIRDXDqmwOO+LVSX1d+GrFQkW1fY2Sw5Ekos277x7Sb/XGNXaUI6UNvS8h1qZTvBu4slVidsz7YiP1Gqe6sCQLfrUbRqgkZZabhTFFGwm6x5QAkGm3Iwdle/LiaTe0+KAR6yQdI3CYiO90gbBamItSbE1gHruHaDAY=
Received: by 10.82.116.15 with SMTP id o15mr8333359buc.10.1204289150094;
        Fri, 29 Feb 2008 04:45:50 -0800 (PST)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id t10sm5880605muh.13.2008.02.29.04.45.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 Feb 2008 04:45:49 -0800 (PST)
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
In-Reply-To: <alpine.LSU.1.00.0802291214160.22527@racer.site>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75529>


> However, there is something ugly waiting for us: we often have
> 
> 	case '/':
> 
> and for Windows, this needs to add
> 
> 	case '\\':

More often than in an "if" statement (so you can add IS_DIR_SEPARATOR 
which is much less ugly than CASE_DIR_SEPARATOR)?

Paolo
