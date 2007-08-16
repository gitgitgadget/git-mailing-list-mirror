From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: git on Cygwin: Not a valid object name HEAD
Date: Wed, 15 Aug 2007 20:27:50 -0400
Message-ID: <46C39A06.7020003@gmail.com>
References: <76795DDC-29A5-4C7E-B56E-A6316A183C75@zib.de> <e7bda7770708101531n782118e9qb9c6de4e934940ea@mail.gmail.com> <EF7DFA5A-9C3A-4D0B-9533-D1D60AE4A44C@zib.de> <e7bda7770708141704m587dfdbdqfbab51b8ac6fcff@mail.gmail.com> <30FE2B1C-B651-4F1D-B5D9-CD3C3261F531@zib.de> <85fy2l1i1g.fsf@lola.goethe.zz> <ABA1D7D2-92A6-4E8C-AC36-93912621E3D4@zib.de> <86k5rx474o.fsf@lola.quinscape.zz> <20070815073811.GL27913@spearce.org> <30e4a070708150542m3f3f5c62l5e4bf5b3ff098b52@mail.gmail.com> <30e4a070708150548r3234cd66yd4ee6a85989a98b1@mail.gmail.com> <3F9AF722-0610-4778-A244-DBE5A0918D0B@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Kastrup <dak@gnu.org>,
	Torgil Svensson <torgil.svensson@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Aug 16 02:28:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILTEA-0000Gw-V5
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 02:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756909AbXHPA2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 20:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756288AbXHPA2U
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 20:28:20 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:58607 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbXHPA2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 20:28:19 -0400
Received: by wx-out-0506.google.com with SMTP id h31so71903wxd
        for <git@vger.kernel.org>; Wed, 15 Aug 2007 17:28:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HI70++tlcn/HnaofYnXTgykf7nh4iDsg1So/PQry7EOuUM+Pvmood+L+ipGZS8scz2Kq1jJX5jU5IDFM9aWukG6sZuqNbcxVR1RJ8L/zpvvV2kbFfeguuv+PKTtD7bBhNyAwxmHTITJ9Ht3RPsPmZatZN5hMnmqm6Dn204l7Aj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AqJ1La+QubXYCIP7XA+qVXVp6KrR7Xp/pDpbDXxgR1uFAUOp46e5Tjl8GcqiXviweCKkXuj5px1WWS5n7pt1rQVt5WAF/+70j+lPM7pAxBqnHeHgKTDIw4dA81reaOlM9RUsOrRxEjOF1BpIdPDw3y4aqp5AUvllQQIyc40jtVc=
Received: by 10.70.84.6 with SMTP id h6mr1794022wxb.1187224074846;
        Wed, 15 Aug 2007 17:27:54 -0700 (PDT)
Received: from ?192.168.100.117? ( [71.246.233.117])
        by mx.google.com with ESMTPS id i16sm465454wxd.2007.08.15.17.27.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 15 Aug 2007 17:27:51 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.12 (Windows/20070509)
In-Reply-To: <3F9AF722-0610-4778-A244-DBE5A0918D0B@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55973>

Steffen Prohaska wrote:
>
> If reg.exe is not there kdiff3 will not be found. The code will
> already be _ignored_. It's just not working.
I'm really thinking forward to when you try to reintegrate this into 
git.git: Platform specific code needs to be wrapped with a test that has 
a known result on all platforms.

Mark
