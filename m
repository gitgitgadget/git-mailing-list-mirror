From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Unexpected cherry-pick behaviour
Date: Sun, 15 Dec 2013 14:48:57 -0000
Organization: OPDS
Message-ID: <0172E9F1B5F945EB9294F1066C2FB72E@PhilipOakley>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com><xmqqvbywts9d.fsf@gitster.dls.corp.google.com><7050e7272bb83d083a56a2c391228ed8@matos-sorge.com><CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com><beee32a53ece8b839578703deb851eaa@matos-sorge.com><CALWbr2y1YDX0dzjpZoF8WL4+ND+8drurH+Wrf1wBs_-=0datOA@mail.gmail.com><3FFF08967D2E480FA6B0E0EE3A72A8D9@PhilipOakley> <7vmwk3gr39.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Antoine Pelisse" <apelisse@gmail.com>,
	"Paulo Matos" <paulo@matos-sorge.com>, "git" <git@vger.kernel.org>,
	<git-owner@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 15 15:48:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsCzg-0000Cj-29
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 15:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600Ab3LOOs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Dec 2013 09:48:28 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:58681 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751571Ab3LOOs1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Dec 2013 09:48:27 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmkZABDBrVJZ8YR9/2dsb2JhbABZgwqJTrAdAQIBAYEYF3RpAQGBHwEBFAEEAQEFCAEBLh4BARwFCwIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYU4BwGCEiXIRo8ZgyqBEwSJC4YTmwyDKjw
X-IPAS-Result: AmkZABDBrVJZ8YR9/2dsb2JhbABZgwqJTrAdAQIBAYEYF3RpAQGBHwEBFAEEAQEFCAEBLh4BARwFCwIDBQIBAxUMJRQBBBoGBxcGEwgCAQIDAYU4BwGCEiXIRo8ZgyqBEwSJC4YTmwyDKjw
X-IronPort-AV: E=Sophos;i="4.95,489,1384300800"; 
   d="scan'208";a="439807564"
Received: from host-89-241-132-125.as13285.net (HELO PhilipOakley) ([89.241.132.125])
  by out1.ip05ir2.opaltelecom.net with SMTP; 15 Dec 2013 14:48:11 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239327>

From: "Junio C Hamano" <gitster@pobox.com>, Saturday, December 14, 2013 
7:39 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> Would this be a good use of the
>>    * Magic pathspecs like ":(icase)
>> that was recently released (v1.8.5  2Dec13)  so that the merge stages
>> can be named.
>
> Because the pathspec mechahism is for you to tell an operation that
> works on a collection of paths (e.g. "all the paths in the HEAD",
> "all the paths at stage #1 in the index") to narrow the set it
> operates on down to only those that match, I do not think it is a
> good match at all to what you are trying to do.
>

My point was that the ":1:" syntax already was a "path at stage #1 in 
the index" indicator, and that it would be good to have a memorable name 
for the :1:2:3: stages as per Antoine's  query.

It maybe that my referring to it as a 'magic pathspec' was a mistake, 
but the difficulty of remembering which number is ours:theirs:base still 
stands.

(for general info; the :<stage>:  format is defined in 'git revision 
(7)' as the last method for Specifying Revisions)

Philip
--
PS should the cc: git-owner@vger.kernel.org be dropped as effectively a 
duplicate? 
