From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] daemon: support <directory> arguments again
Date: Tue, 04 Jan 2011 11:18:26 -0800
Message-ID: <7vlj30fpfh.fsf@alter.siamese.dyndns.org>
References: <1288834524-2400-1-git-send-email-kusmabite@gmail.com>
 <1288834524-2400-9-git-send-email-kusmabite@gmail.com>
 <20110104040446.GA3541@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:18:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCP7-00037n-40
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1ADTSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:18:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33403 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1ADTSf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:18:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 805CE2FA3;
	Tue,  4 Jan 2011 14:19:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=lyI1/ATF3qhI8MtfWzIbZja
	c1X2ibSNULnQSGkdslCuBB9e4kymq1LMuHJJu8XrRXlzVFfrkLois+Ua29fPIf6b
	1W6dIlcn/NQfTrbb2LbIKOOA+jVtf4CgMaSOXT/5Ow6lb5sFCJvrp//wifE2XN7l
	kJiJVkvfe7lYYjFce4Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=joxnZ+hHWs59dspNncbj4U+ZbpwuSov+nj1SWmmCJyDqfBePa
	+7fOl4tgqDBnEF2LXMACREOwzqeJjFIX8zlKc5WoE6hTl2oh79FKhKQk4Ib6x1O6
	JnNpKeqJrttlj3vMrl0eYuZcxb/meJvfD6Qs4EIFy052NZcu90QY2WBam8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4AB462FA1;
	Tue,  4 Jan 2011 14:19:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1740A2F9F; Tue,  4 Jan 2011
 14:19:03 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80B3DC18-1837-11E0-842F-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164509>

Thanks.
