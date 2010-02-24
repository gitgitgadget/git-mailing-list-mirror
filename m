From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] pull: fix 'git pull --all' when current branch is
 tracking remote that is not last in the list of remotes
Date: Wed, 24 Feb 2010 14:33:58 +0100
Message-ID: <4B852AC6.8040508@gnu.org>
References: <7vzl2zxz20.fsf@alter.siamese.dyndns.org> <1267016842-3380-1-git-send-email-michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 14:34:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkHNS-0006wY-Rg
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 14:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757074Ab0BXNeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 08:34:05 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:58836 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757024Ab0BXNeB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 08:34:01 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1206178fga.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 05:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=EBQCKVgXEEUarD5idxXn/orcm4MqyKZipl46/6iB1t8=;
        b=bwFwDeoYi8bS2WNA1vRo8Mk04tjkhYHE2wtKxVXNVmxntyCcgKgCeK5k4MfxTSI8cd
         ROGB3Y+4Cl6Wndwkis3Z08pdlsmY0YhRZ7PLPlrL3wB207eftSv26MAaDD6FheZa1vA3
         EgXLXSHdvT9ulmx8MkQWQjpysVu91xvkXPynI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=nBmzRfACpw9HiCipT0FFEgT1YzrR7Q4fGpDr/ql22w7KNCLk/bxI0mRcfvGq7Ew1RQ
         bRopHOrma+8b385CGgkt9rNqChltTRbhbZF/LPuv+11TFHb3Y1L+TaHdxN4ifuuiQris
         4HgJ0iJiEV8yeTLtagGwCs+cxEyMOcdVTcTSU=
Received: by 10.87.66.14 with SMTP id t14mr21060055fgk.60.1267018440662;
        Wed, 24 Feb 2010 05:34:00 -0800 (PST)
Received: from yakj.usersys.redhat.com (93-34-208-53.ip51.fastwebnet.it [93.34.208.53])
        by mx.google.com with ESMTPS id 3sm35631fge.26.2010.02.24.05.33.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Feb 2010 05:33:59 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.1
In-Reply-To: <1267016842-3380-1-git-send-email-michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140942>

On 02/24/2010 02:07 PM, Michael Lukashov wrote:
> +if test -e "$GIT_DIR"/FETCH_HEAD
> +then
> +	rm -f "$GIT_DIR"/FETCH_HEAD || exit
> +fi

You do not need the if.

Paolo
