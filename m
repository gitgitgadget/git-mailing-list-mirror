From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 18:26:07 +0200
Message-ID: <520BAF9F.70105@googlemail.com>
References: <1376421797-26443-1-git-send-email-stefanbeller@googlemail.com> <1376421797-26443-2-git-send-email-stefanbeller@googlemail.com> <vpqy584n36a.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE3DF6D8B3995ADAF93D56AB8"
Cc: git@vger.kernel.org, pclouds@gmail.com, iveqy@iveqy.com,
	gitster@pobox.com, apelisse@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 14 18:26:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9dtj-0006NS-LN
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 18:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662Ab3HNQ0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 12:26:07 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:63250 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932656Ab3HNQ0F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 12:26:05 -0400
Received: by mail-wi0-f170.google.com with SMTP id hi8so4411468wib.5
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=6dWZGdwSxwswjExlZAEwArVD08qLqqtMs+ePNPhLmyY=;
        b=R2BINzP4AXG9HFqeBN98h2rHZSne+XPjGrbkCPyHu2ntZjJGrJnTmKEG9w4S6Ex38o
         ITZxPtNwKMIryTWRWQYcrQ/JZssi0ftkW53eVIZrN0xKZucEgnS3YFLofNgfzJi3CSLE
         3YGPS5eL0R/A9ruuvTQnPtnvrv0k6MufMfdCu8SUsrN0L/dgypYvJeR2IEW4IB8EUW8u
         bAfEXkbFBMzS/yGJWw3CTFGNTbJDxCizvO3WugZNofBU7q0J6B95QHZiVUTOAl0CaX61
         dBXBgPu9smvsTsTSk3uZCD3+Bi/oMWNARTiEXfjiyna7DHQeSG9f6xTYpkVaGyU/NpwN
         NAxA==
X-Received: by 10.194.11.38 with SMTP id n6mr5378536wjb.25.1376497563380;
        Wed, 14 Aug 2013 09:26:03 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id v9sm3987808wiw.8.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 14 Aug 2013 09:26:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <vpqy584n36a.fsf@anie.imag.fr>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232291>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE3DF6D8B3995ADAF93D56AB8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/14/2013 09:26 AM, Matthieu Moy wrote:
> I suggested that you first enrich the test suite if needed. Did you
> check that the testsuite had good enough coverage for git-repack?

There are already quite some tests using git-repack for testing other
purposes. Also git repack seems to be called from other commands
internally such as "git notes prune" or "git gc".

I'll look into enhancing the test suite once I got the rewritten
code working on the current test suite.

Stefan




--------------enigE3DF6D8B3995ADAF93D56AB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSC6+fAAoJEJQCPTzLflhqWDEQAMrNkKxo12bWm1K9s0AH/SIS
wdAMMixdtZeEDdfioczaq5plyei2cy7IYq0LuPFKFcYARdTVs1MAM2Ec+uKYZvo5
uRBZLjfpnVfUiN8ZoObEVx44Hg7Y5ye9RXQlI+EAoei1lkqkZJpSeeIOZlw0pZ/w
ZX+FKhPr5ahR0cI3sc1nC1CUX2M8MyQs9dIiMCZDL/uC/ttNs0FjGnwiFej2XZ1u
cfGw457qyDHtP8D2gR6IdniJqXu+mWYELs8Yucee5sYZTT3Z7j4mz0o0SokYFHqf
b7iRzFUY3inNv/hdGG64lWvbygneqVIem0F/LRO/+VX4LcQ54xd4X/R+S+UppZot
cvPHftmT7ncsz3MqNXVaQIXc4R6MehUZbnS8HStUjkOp8Qz4lNMulfgVayq3XfaZ
RYoac9Vo2ISZfnMZfXENd3e/seXpCXghy05WIeujoihkRmGqdF9Q4MXhONoS2sNH
PESFWfVEt2+xfobS/FFeeGnOMhqQOys9ZbkQCWtpUUfDVKculztQF8gjS0IdD3JV
19+4I6vKerY/ZMXcUuBw3QMQDTv6NfjWBwETedZPEhdHSK1FmU+WK//VRBSVRVuQ
91ONi2zfsWOCNowATVQmpH5iUcNhBDQ13LZWK7mqsAavGbl0uGAUF1SVgj9zAI22
P5YtZP49vC3Tj5H2lUZR
=QI7W
-----END PGP SIGNATURE-----

--------------enigE3DF6D8B3995ADAF93D56AB8--
