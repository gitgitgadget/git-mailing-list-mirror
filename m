From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] t9129: use "$PERL_PATH" instead of "perl"
Date: Fri, 07 Jan 2011 10:49:05 -0800
Message-ID: <7vlj2w7dni.fsf@alter.siamese.dyndns.org>
References: <1274193685-5468-1-git-send-email-yann@droneaud.fr>
 <4BF2BABC.2010405@drmicha.warpmail.net> <1274202486.4228.22.camel@localhost>
 <1274720888.4838.13.camel@localhost> <cover.1294312018.git.yann@droneaud.fr>
 <74b3db2e538abb4c06d7a0792dff9d78636e2758.1294312018.git.yann@droneaud.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Yann Droneaud <yann@droneaud.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 19:49:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbHNo-0001wt-P3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 19:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754640Ab1AGStN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 13:49:13 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35073 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab1AGStM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 13:49:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26E812E2B;
	Fri,  7 Jan 2011 13:49:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hwdZJkfI78UwFSZkcXnKHD3W+zc=; b=k+7Yuw
	iJfwrGOf8hyeH1v7mIYKs66ImjRJvZLptSZ8yIafDp0+UazesTMcXN9rEEhsYREn
	Hs0aCIsBeeZjfAva7XK3q96g50XDKO1or0OVZfflxiggbsc9NWFhwcTFOUwTHloo
	XOQyWGGyt1WQRYUEJoUcplKUXeYG9aW46Y4/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U4/Q1N00yZmEh25sQBZEbDoP9ANjQWBV
	5KqZFbSDodDXbC1vLcCr+yDlhoOEPdyX5YRbB9GYIzJhOb+S5QflzMvyFoenIk8h
	SsVi999Qs9QpyBvalxy2sANUoR/sRrQLY8uirFqAXZudtCT39EZfZeuSj75Mn5u6
	+eqhUSYJ490=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 050AE2E2A;
	Fri,  7 Jan 2011 13:49:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 203BB2E29; Fri,  7 Jan 2011
 13:49:45 -0500 (EST)
In-Reply-To: <74b3db2e538abb4c06d7a0792dff9d78636e2758.1294312018.git.yann@droneaud.fr>
 (Yann Droneaud's message of "Thu\,  6 Jan 2011 15\:22\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E753E25C-1A8E-11E0-97F4-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164739>

Squash this to 3/4, perhaps saying "while at it, fix $this".
