From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] cache-tree: update API to take abitrary flags
Date: Wed, 11 Jan 2012 15:48:42 -0800
Message-ID: <7vmx9t6bs5.fsf@alter.siamese.dyndns.org>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 <1326275982-29866-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 00:48:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rl7uU-0005Qh-Ih
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 00:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216Ab2AKXsp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 18:48:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939Ab2AKXsp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 18:48:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B19F6095;
	Wed, 11 Jan 2012 18:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jWKbmG4RI1Kt
	WFqi4exYU80booQ=; b=DEb5SuN3WZzTOg/blJrnI6WpFK2GeNi8h2EAUgRdKDk7
	oCjmpOiQtnnm1PlhgXYV2SWqIuNbdsfU/y+1rl+2IPFzpNnPMnI4XJlZdPcfWPLB
	NftOkNty6ggHAMMsQf0ZN9Ts0M9if4MlIwK/vO0klNU2jGTUW2Jw1c1RQoe0fEs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=M5ReOM
	5u5UUiFb6h2Hb/RJhgC8YAlmHFRcc7CbHkF+L0Dh8UeuzuoXXDpTIfFZvcRCVMox
	PRPCPDpCQpqgr2Fmx9805xYKW4PwTcEonOO0jSDVTf/K8u+WQLLFkGLpK8EOl/KX
	sL0O1yyPKgbTxZ3JG/+x/xqbXyG4m0Tk4lk2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 035346094;
	Wed, 11 Jan 2012 18:48:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73CD56093; Wed, 11 Jan 2012
 18:48:43 -0500 (EST)
In-Reply-To: <1326275982-29866-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11 Jan
 2012 16:59:41 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CB8D722A-3CAE-11E1-89FE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188405>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ---

Thanks; this one looks very sensible regardless of what follows (or doe=
s
not follow).  Forgot to sign-off?
